import fs from "node:fs";
import path from "node:path";
import process from "node:process";

const TOOL_VERSION = "0.1.0";

const DEFAULT_IGNORES = new Set([
  ".git",
  "node_modules",
  "vendor",
  "dist",
  "build",
  "coverage",
  ".next",
  ".turbo",
]);

function statSafe(p) {
  try {
    return fs.statSync(p);
  } catch {
    return null;
  }
}

function readFileSafe(p, maxBytes = 256 * 1024) {
  try {
    const buf = fs.readFileSync(p);
    if (buf.byteLength > maxBytes) return buf.subarray(0, maxBytes).toString("utf8");
    return buf.toString("utf8");
  } catch {
    return null;
  }
}

function scanForTokens(repoRoot, { tokens, exts, maxFiles = 2500, maxDepth = 8 }) {
  const loweredTokens = tokens.map((t) => t.toLowerCase());
  const matches = new Map();

  const { results: files, truncated } = findFilesRecursive(
    repoRoot,
    (p) => {
      const ext = path.extname(p).toLowerCase();
      return exts.includes(ext);
    },
    { maxFiles, maxDepth }
  );

  for (const filePath of files) {
    const contents = readFileSafe(filePath, 128 * 1024);
    if (!contents) continue;
    const haystack = contents.toLowerCase();

    for (let i = 0; i < loweredTokens.length; i += 1) {
      const token = loweredTokens[i];
      if (matches.has(token)) continue;
      if (haystack.includes(token)) matches.set(token, path.relative(repoRoot, filePath));
    }
    if (matches.size === loweredTokens.length) break;
  }

  return {
    truncated,
    matches: Object.fromEntries([...matches.entries()]),
  };
}

function existsFile(p) {
  const st = statSafe(p);
  return Boolean(st && st.isFile());
}

function existsDir(p) {
  const st = statSafe(p);
  return Boolean(st && st.isDirectory());
}

function detectPackageManager(repoRoot) {
  const hasPnpm = existsFile(path.join(repoRoot, "pnpm-lock.yaml"));
  const hasYarn = existsFile(path.join(repoRoot, "yarn.lock"));
  const hasNpm = existsFile(path.join(repoRoot, "package-lock.json"));
  const hasBun = existsFile(path.join(repoRoot, "bun.lockb")) || existsFile(path.join(repoRoot, "bun.lock"));
  if (hasPnpm) return "pnpm";
  if (hasYarn) return "yarn";
  if (hasBun) return "bun";
  if (hasNpm) return "npm";
  return null;
}

function findFilesRecursive(repoRoot, predicate, { maxFiles = 6000, maxDepth = 8 } = {}) {
  const results = [];
  const queue = [{ dir: repoRoot, depth: 0 }];
  let visited = 0;

  while (queue.length > 0) {
    const { dir, depth } = queue.shift();
    if (depth > maxDepth) continue;

    let entries;
    try {
      entries = fs.readdirSync(dir, { withFileTypes: true });
    } catch {
      continue;
    }

    for (const ent of entries) {
      const fullPath = path.join(dir, ent.name);
      if (ent.isDirectory()) {
        if (DEFAULT_IGNORES.has(ent.name)) continue;
        queue.push({ dir: fullPath, depth: depth + 1 });
        continue;
      }
      if (!ent.isFile()) continue;

      visited += 1;
      if (visited > maxFiles) return { results, truncated: true };
      if (predicate(fullPath)) results.push(fullPath);
    }
  }

  return { results, truncated: false };
}

function detectPluginHeaderFromPhpFile(filePath) {
  const contents = readFileSafe(filePath, 128 * 1024);
  if (!contents) return null;
  const headerMatch = contents.match(/^\s*Plugin Name:\s*(.+)\s*$/im);
  if (!headerMatch) return null;
  return headerMatch[1].trim();
}

function detectThemeHeaderFromStyleCss(filePath) {
  const contents = readFileSafe(filePath, 128 * 1024);
  if (!contents) return null;
  const headerMatch = contents.match(/^\s*Theme Name:\s*(.+)\s*$/im);
  if (!headerMatch) return null;
  return headerMatch[1].trim();
}

function guessWpCoreVersionFromCheckout(repoRoot) {
  const versionPhp = path.join(repoRoot, "wp-includes", "version.php");
  if (!existsFile(versionPhp)) return { value: null, source: null };
  const contents = readFileSafe(versionPhp, 64 * 1024);
  if (!contents) return { value: null, source: null };
  const match = contents.match(/\$wp_version\s*=\s*'([^']+)'/);
  if (!match) return { value: null, source: "wp-includes/version.php" };
  return { value: match[1], source: "wp-includes/version.php" };
}

function guessGutenbergVersion(repoRoot) {
  const gutenbergPackageJson = path.join(repoRoot, "packages", "plugins", "package.json");
  const rootPackageJson = path.join(repoRoot, "package.json");

  for (const candidate of [gutenbergPackageJson, rootPackageJson]) {
    if (!existsFile(candidate)) continue;
    const txt = readFileSafe(candidate);
    if (!txt) continue;
    try {
      const pkg = JSON.parse(txt);
      if (pkg?.name === "@wordpress/plugins" && typeof pkg?.version === "string") {
        return { value: pkg.version, source: path.relative(repoRoot, candidate) };
      }
      if (pkg?.name === "gutenberg" && typeof pkg?.version === "string") {
        return { value: pkg.version, source: path.relative(repoRoot, candidate) };
      }
    } catch {
      // ignore
    }
  }
  return { value: null, source: null };
}

function parsePackageJson(repoRoot) {
  const p = path.join(repoRoot, "package.json");
  if (!existsFile(p)) return null;
  const txt = readFileSafe(p);
  if (!txt) return null;
  try {
    return JSON.parse(txt);
  } catch {
    return null;
  }
}

function parseComposerJson(repoRoot) {
  const p = path.join(repoRoot, "composer.json");
  if (!existsFile(p)) return null;
  const txt = readFileSafe(p);
  if (!txt) return null;
  try {
    return JSON.parse(txt);
  } catch {
    return null;
  }
}

function detectConfigConstants(repoRoot) {
  const { results: configFiles } = findFilesRecursive(repoRoot, (p) => path.basename(p) === "wp-config.php", {
    maxFiles: 4000,
    maxDepth: 4,
  });
  const configPath = configFiles[0] ?? null;
  if (!configPath) {
    return { source: null, constants: {} };
  }

  const contents = readFileSafe(configPath, 256 * 1024);
  if (!contents) return { source: path.relative(repoRoot, configPath), constants: {} };

  const c = contents;
  const enabled = (name) =>
    new RegExp(`define\\(\\s*['"]${name}['"]\\s*,\\s*(true|1)\\s*\\)`, "i").test(c) ||
    new RegExp(`\\b${name}\\b\\s*=\\s*(true|1)`, "i").test(c);

  const mentioned = (name) => new RegExp(`\\b${name}\\b`, "i").test(c);

  return {
    source: path.relative(repoRoot, configPath),
    constants: {
      savequeriesMentioned: mentioned("SAVEQUERIES"),
      savequeriesEnabled: enabled("SAVEQUERIES"),
      wpDebugMentioned: mentioned("WP_DEBUG"),
      wpDebugEnabled: enabled("WP_DEBUG"),
      disableWpCronMentioned: mentioned("DISABLE_WP_CRON"),
      disableWpCronEnabled: enabled("DISABLE_WP_CRON"),
    },
  };
}

function detectKinds(repoRoot, signals) {
  const kinds = new Set();

  if (signals.isGutenbergRepo) kinds.add("gutenberg");
  if (signals.isWpCoreCheckout) kinds.add("wp-core");
  if (signals.hasWpContentDir) kinds.add("wp-site");
  if (signals.detectedThemeName) kinds.add(signals.isBlockTheme ? "wp-block-theme" : "wp-theme");
  if (signals.detectedPluginName) kinds.add(signals.isBlockPlugin ? "wp-block-plugin" : "wp-plugin");
  if (signals.hasMuPluginsDir) kinds.add("wp-mu-plugin");

  if (kinds.size === 0) kinds.add("unknown");

  const priority = [
    "gutenberg",
    "wp-core",
    "wp-site",
    "wp-block-theme",
    "wp-block-plugin",
    "wp-theme",
    "wp-mu-plugin",
    "wp-plugin",
    "unknown",
  ];
  let primary = "unknown";
  for (const k of priority) {
    if (kinds.has(k)) {
      primary = k;
      break;
    }
  }

  return { kind: [...kinds], primary };
}

function buildRecommendations({ repoRoot, primaryKind, packageManager, packageJson, composerJson, tooling, signals }) {
  const commands = [];
  const notes = [];

  if (tooling.node.hasPackageJson) {
    const pm = packageManager ?? "npm";
    const run = pm === "yarn" ? "yarn" : `${pm} run`;
    const hasScript = (name) => Boolean(packageJson?.scripts && Object.prototype.hasOwnProperty.call(packageJson.scripts, name));
    if (hasScript("lint")) commands.push(`${run} lint`);
    if (hasScript("test")) commands.push(`${run} test`);
    if (hasScript("build")) commands.push(`${run} build`);
    if (hasScript("start")) commands.push(`${run} start`);
    if (tooling.node.usesWordpressScripts) notes.push("Detected @wordpress/scripts usage; prefer its standard lint/build/test scripts.");
  }

  if (tooling.php.hasComposerJson) {
    commands.push("composer install");
    if (tooling.php.phpunitXml.length > 0) commands.push("vendor/bin/phpunit");
  }

  if (tooling.tests.hasWpEnv) notes.push("Detected wp-env; E2E workflows may rely on Docker.");
  if (signals.scanTruncated) notes.push("Scan truncated due to file limit; some signals may be missing.");
  if (primaryKind === "unknown") notes.push("Could not confidently classify repo; inspect root for plugin/theme headers or wp-content structure.");

  return { commands, notes };
}

function main() {
  const repoRoot = process.cwd();

  const wpContent = path.join(repoRoot, "wp-content");
  const pluginsDir = path.join(wpContent, "plugins");
  const muPluginsDir = path.join(wpContent, "mu-plugins");
  const themesDir = path.join(wpContent, "themes");

  const isWpCoreCheckout = existsFile(path.join(repoRoot, "wp-includes", "version.php"));
  const isGutenbergRepo =
    existsDir(path.join(repoRoot, "packages")) &&
    (existsDir(path.join(repoRoot, "packages", "block-editor")) || existsDir(path.join(repoRoot, "packages", "components")));

  const packageJson = parsePackageJson(repoRoot);
  const composerJson = parseComposerJson(repoRoot);
  const packageManager = detectPackageManager(repoRoot);

  const usesWordpressScripts = Boolean(
    packageJson?.devDependencies?.["@wordpress/scripts"] ||
      packageJson?.dependencies?.["@wordpress/scripts"] ||
      packageJson?.scripts?.build?.includes("wp-scripts") ||
      packageJson?.scripts?.start?.includes("wp-scripts") ||
      packageJson?.scripts?.test?.includes("wp-scripts") ||
      packageJson?.scripts?.lint?.includes("wp-scripts")
  );

  const pkgHasInteractivity = Boolean(
    packageJson?.devDependencies?.["@wordpress/interactivity"] || packageJson?.dependencies?.["@wordpress/interactivity"]
  );
  const pkgHasAbilities = Boolean(
    packageJson?.devDependencies?.["@wordpress/abilities"] || packageJson?.dependencies?.["@wordpress/abilities"]
  );

  const hasWpContentDir = existsDir(wpContent);
  const hasPluginsDir = existsDir(pluginsDir);
  const hasThemesDir = existsDir(themesDir);
  const hasMuPluginsDir = existsDir(muPluginsDir);

  const config = detectConfigConstants(repoRoot);

  const pluginCandidates = [];
  const themeCandidates = [];

  // Root-level plugin/theme detection (common when repo root is the plugin/theme).
  for (const entry of fs.readdirSync(repoRoot, { withFileTypes: true })) {
    if (!entry.isFile()) continue;
    if (entry.name.toLowerCase().endsWith(".php")) pluginCandidates.push(path.join(repoRoot, entry.name));
    if (entry.name === "style.css") themeCandidates.push(path.join(repoRoot, entry.name));
  }

  let detectedPluginName = null;
  for (const phpFile of pluginCandidates) {
    detectedPluginName = detectPluginHeaderFromPhpFile(phpFile);
    if (detectedPluginName) break;
  }

  let detectedThemeName = null;
  for (const styleCss of themeCandidates) {
    detectedThemeName = detectThemeHeaderFromStyleCss(styleCss);
    if (detectedThemeName) break;
  }

  const { results: blockJsonFiles, truncated: scanTruncated } = findFilesRecursive(
    repoRoot,
    (p) => path.basename(p) === "block.json",
    { maxFiles: 6000, maxDepth: 8 }
  );
  const { results: themeJsonFiles } = findFilesRecursive(repoRoot, (p) => path.basename(p) === "theme.json", {
    maxFiles: 6000,
    maxDepth: 8,
  });

  const templatesDirCandidates = [
    path.join(repoRoot, "templates"),
    path.join(repoRoot, "parts"),
    path.join(repoRoot, "patterns"),
  ];

  const isBlockTheme = themeJsonFiles.length > 0 && templatesDirCandidates.some((p) => existsDir(p));
  const isBlockPlugin = blockJsonFiles.length > 0;

  const interactivityScan = scanForTokens(repoRoot, {
    tokens: ["data-wp-interactive", "@wordpress/interactivity", "viewScriptModule"],
    exts: [".php", ".js", ".ts", ".tsx", ".json", ".html"],
    maxFiles: 2500,
    maxDepth: 8,
  });

  const abilitiesScan = scanForTokens(repoRoot, {
    tokens: [
      "wp_register_ability(",
      "wp_register_ability_category(",
      "wp_abilities_api_init",
      "wp_abilities_api_categories_init",
      "wp-abilities/v1",
      "@wordpress/abilities",
    ],
    exts: [".php", ".js", ".ts", ".tsx"],
    maxFiles: 2500,
    maxDepth: 8,
  });

  const innerBlocksScan = scanForTokens(repoRoot, {
    tokens: ["InnerBlocks", "useInnerBlocksProps", "InnerBlocks.Content"],
    exts: [".js", ".ts", ".tsx"],
    maxFiles: 2500,
    maxDepth: 8,
  });

  const wpCliConfigBasenames = new Set([
    "wp-cli.yml",
    "wp-cli.yaml",
    "wp-cli.local.yml",
    "wp-cli.local.yaml",
    ".wp-cli.yml",
    ".wp-cli.yaml",
  ]);
  const { results: wpCliConfigFiles, truncated: wpCliConfigTruncated } = findFilesRecursive(
    repoRoot,
    (p) => wpCliConfigBasenames.has(path.basename(p)),
    { maxFiles: 6000, maxDepth: 6 }
  );

  const composerRequire = composerJson?.require && typeof composerJson.require === "object" ? composerJson.require : {};
  const composerRequireDev =
    composerJson?.["require-dev"] && typeof composerJson["require-dev"] === "object" ? composerJson["require-dev"] : {};
  const composerHasWpCli = Boolean(
    composerRequire["wp-cli/wp-cli"] ||
      composerRequireDev["wp-cli/wp-cli"] ||
      composerRequire["wp-cli/wp-cli-bundle"] ||
      composerRequireDev["wp-cli/wp-cli-bundle"]
  );

  const wpCliTokenScan = scanForTokens(repoRoot, {
    tokens: [
      "wp search-replace",
      "wp db export",
      "wp db import",
      "wp cron event",
      "wp cache flush",
      "wp rewrite flush",
      "wp plugin update",
      "wp theme update",
    ],
    exts: [".sh", ".yml", ".yaml", ".js", ".ts", ".php", ".json"],
    maxFiles: 2500,
    maxDepth: 8,
  });

  const usesInteractivityApi = pkgHasInteractivity || Object.keys(interactivityScan.matches).length > 0;
  const usesAbilitiesApi = pkgHasAbilities || Object.keys(abilitiesScan.matches).length > 0;
  const usesInnerBlocks = Object.keys(innerBlocksScan.matches).length > 0;
  const usesWpCli = composerHasWpCli || wpCliConfigFiles.length > 0 || Object.keys(wpCliTokenScan.matches).length > 0;

  const wpContentRoot = path.join(repoRoot, "wp-content");
  const hasObjectCacheDropin = existsFile(path.join(wpContentRoot, "object-cache.php"));
  const hasAdvancedCacheDropin = existsFile(path.join(wpContentRoot, "advanced-cache.php"));
  const hasDbDropin = existsFile(path.join(wpContentRoot, "db.php"));
  const hasSunriseDropin = existsFile(path.join(wpContentRoot, "sunrise.php"));
  const hasQueryMonitorPlugin = existsDir(path.join(wpContentRoot, "plugins", "query-monitor"));
  const hasPerformanceLabPlugin = existsDir(path.join(wpContentRoot, "plugins", "performance-lab"));

  const phpunitXml = [];
  for (const candidate of ["phpunit.xml", "phpunit.xml.dist"]) {
    const full = path.join(repoRoot, candidate);
    if (existsFile(full)) phpunitXml.push(candidate);
  }

  const hasWpEnv =
    existsFile(path.join(repoRoot, ".wp-env.json")) ||
    existsFile(path.join(repoRoot, ".wp-env.override.json")) ||
    Boolean(packageJson?.devDependencies?.["@wordpress/env"] || packageJson?.dependencies?.["@wordpress/env"]);

  const hasPlaywright = Boolean(
    packageJson?.devDependencies?.["@playwright/test"] ||
      packageJson?.dependencies?.["@playwright/test"] ||
      packageJson?.devDependencies?.["@wordpress/e2e-test-utils-playwright"] ||
      packageJson?.dependencies?.["@wordpress/e2e-test-utils-playwright"]
  );

  const hasJest = Boolean(
    packageJson?.devDependencies?.jest ||
      packageJson?.dependencies?.jest ||
      packageJson?.devDependencies?.["@wordpress/jest-preset-default"] ||
      packageJson?.dependencies?.["@wordpress/jest-preset-default"]
  );

  const hasPhpUnit = phpunitXml.length > 0 || Boolean(composerJson?.requireDev?.phpunit || composerJson?.["require-dev"]?.phpunit);

  const signals = {
    paths: {
      repoRoot,
      wpContent: hasWpContentDir ? wpContent : null,
      pluginsDir: hasPluginsDir ? pluginsDir : null,
      themesDir: hasThemesDir ? themesDir : null,
      muPluginsDir: hasMuPluginsDir ? muPluginsDir : null,
    },
    isWpCoreCheckout,
    isGutenbergRepo,
    hasWpContentDir,
    hasPluginsDir,
    hasThemesDir,
    hasMuPluginsDir,
    detectedPluginName,
    detectedThemeName,
    isBlockPlugin,
    isBlockTheme,
    usesInteractivityApi,
    usesAbilitiesApi,
    usesInnerBlocks,
    usesWpCli,
    performanceHints: {
      wpConfig: config.source,
      constants: config.constants,
      dropins: {
        objectCache: hasObjectCacheDropin,
        advancedCache: hasAdvancedCacheDropin,
        db: hasDbDropin,
        sunrise: hasSunriseDropin,
      },
      plugins: {
        queryMonitor: hasQueryMonitorPlugin,
        performanceLab: hasPerformanceLabPlugin,
      },
    },
    interactivityHints: {
      packageJson: pkgHasInteractivity,
      matches: interactivityScan.matches,
      scanTruncated: interactivityScan.truncated,
    },
    abilitiesHints: {
      packageJson: pkgHasAbilities,
      matches: abilitiesScan.matches,
      scanTruncated: abilitiesScan.truncated,
    },
    innerBlocksHints: {
      matches: innerBlocksScan.matches,
      scanTruncated: innerBlocksScan.truncated,
    },
    wpCliHints: {
      configFiles: wpCliConfigFiles.map((p) => path.relative(repoRoot, p)).slice(0, 50),
      configScanTruncated: wpCliConfigTruncated,
      composerJson: composerHasWpCli,
      matches: wpCliTokenScan.matches,
      scanTruncated: wpCliTokenScan.truncated,
    },
    blockJsonFiles: blockJsonFiles.map((p) => path.relative(repoRoot, p)).slice(0, 50),
    themeJsonFiles: themeJsonFiles.map((p) => path.relative(repoRoot, p)).slice(0, 50),
    scanTruncated,
  };

  const { kind, primary } = detectKinds(repoRoot, signals);

  const versions = {
    wordpress: {
      core: guessWpCoreVersionFromCheckout(repoRoot),
    },
    gutenberg: guessGutenbergVersion(repoRoot),
  };

  const tooling = {
    php: {
      hasComposerJson: existsFile(path.join(repoRoot, "composer.json")),
      hasVendorDir: existsDir(path.join(repoRoot, "vendor")),
      phpunitXml,
    },
    node: {
      hasPackageJson: existsFile(path.join(repoRoot, "package.json")),
      packageManager,
      usesWordpressScripts,
    },
    tests: {
      hasPhpUnit,
      hasWpEnv,
      hasPlaywright,
      hasJest,
    },
  };

  const recommendations = buildRecommendations({
    repoRoot,
    primaryKind: primary,
    packageManager,
    packageJson,
    composerJson,
    tooling,
    signals,
  });

  const report = {
    tool: { name: "detect_wp_project", version: TOOL_VERSION },
    project: { kind, primary, notes: [] },
    signals,
    tooling,
    versions,
    recommendations,
  };

  process.stdout.write(`${JSON.stringify(report, null, 2)}\n`);
}

main();
