import {
  SKILLS_MAP,
  COMBO_SKILLS_MAP,
  FRONTEND_BONUS_SKILLS,
  WEB_FRONTEND_EXTENSIONS,
  AGENT_FOLDER_MAP,
} from "./skills-map.mjs";

function pushIndex(map, key, value) {
  if (!map[key]) map[key] = [];
  if (!map[key].includes(value)) map[key].push(value);
}

function normalizeComboRule(combo) {
  return {
    ...combo,
    addSkills: combo.addSkills ?? combo.skills ?? [],
    boostSkills: combo.boostSkills ?? [],
  };
}

export function buildRuntimeRegistry(technologies = SKILLS_MAP, combos = COMBO_SKILLS_MAP) {
  const technologyById = Object.create(null);
  const packageToTechIds = Object.create(null);
  const configFileToTechIds = Object.create(null);
  const contentMatchersByFile = Object.create(null);
  const gradleContentMatchers = [];

  for (const tech of technologies) {
    technologyById[tech.id] = tech;

    const detect = tech.detect || {};

    for (const pkg of detect.packages || []) {
      pushIndex(packageToTechIds, pkg, tech.id);
    }

    for (const file of detect.configFiles || []) {
      pushIndex(configFileToTechIds, file, tech.id);
    }

    if (detect.configFileContent) {
      const entry = {
        techId: tech.id,
        patterns: [...(detect.configFileContent.patterns || [])],
      };

      if (detect.configFileContent.scanGradleLayout) {
        gradleContentMatchers.push(entry);
      } else {
        for (const file of detect.configFileContent.files || []) {
          if (!contentMatchersByFile[file]) contentMatchersByFile[file] = [];
          contentMatchersByFile[file].push(entry);
        }
      }
    }
  }

  return {
    technologies,
    technologyById,
    combos: combos.map(normalizeComboRule),
    frontendBonusSkills: [...FRONTEND_BONUS_SKILLS],
    webFrontendExtensions: WEB_FRONTEND_EXTENSIONS,
    agentFolderMap: AGENT_FOLDER_MAP,
    indexes: {
      packageToTechIds,
      configFileToTechIds,
      contentMatchersByFile,
      gradleContentMatchers,
    },
  };
}

export const RUNTIME_REGISTRY = buildRuntimeRegistry();

export const NORMALIZED_COMBO_SKILLS_MAP = RUNTIME_REGISTRY.combos;
export const PACKAGE_TO_TECH_IDS = RUNTIME_REGISTRY.indexes.packageToTechIds;
export const CONFIG_FILE_TO_TECH_IDS = RUNTIME_REGISTRY.indexes.configFileToTechIds;
export const CONTENT_MATCHERS_BY_FILE = RUNTIME_REGISTRY.indexes.contentMatchersByFile;
export const GRADLE_CONTENT_MATCHERS = RUNTIME_REGISTRY.indexes.gradleContentMatchers;

export function getTechnologyById(id) {
  return RUNTIME_REGISTRY.technologyById[id] || null;
}

export function getComboSkills(combo) {
  return combo.addSkills ?? combo.skills ?? [];
}

export function getComboBoostSkills(combo) {
  return combo.boostSkills ?? [];
}
