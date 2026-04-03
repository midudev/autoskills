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

function normalizeCombo(combo) {
  return {
    ...combo,
    add: combo.add ?? combo.skills ?? [],
  };
}

export function buildRuntimeRegistry(technologies = SKILLS_MAP, combos = COMBO_SKILLS_MAP) {
  const technologyById = Object.create(null);
  const byPackage = Object.create(null);
  const byConfigFile = Object.create(null);
  const byFileContent = Object.create(null);
  const byGradleContent = [];

  for (const tech of technologies) {
    technologyById[tech.id] = tech;

    const detect = tech.detect || {};

    for (const pkg of detect.packages || []) {
      pushIndex(byPackage, pkg, tech.id);
    }

    for (const file of detect.configFiles || []) {
      pushIndex(byConfigFile, file, tech.id);
    }

    if (detect.configFileContent) {
      const entry = {
        techId: tech.id,
        patterns: [...(detect.configFileContent.patterns || [])],
      };

      if (detect.configFileContent.scanGradleLayout) {
        byGradleContent.push(entry);
      } else {
        for (const file of detect.configFileContent.files || []) {
          if (!byFileContent[file]) byFileContent[file] = [];
          byFileContent[file].push(entry);
        }
      }
    }
  }

  return {
    technologies,
    technologyById,
    combos: combos.map(normalizeCombo),
    frontendBonusSkills: [...FRONTEND_BONUS_SKILLS],
    webFrontendExtensions: WEB_FRONTEND_EXTENSIONS,
    agentFolderMap: AGENT_FOLDER_MAP,
    indexes: {
      byPackage,
      byConfigFile,
      byFileContent,
      byGradleContent,
    },
  };
}

export const RUNTIME_REGISTRY = buildRuntimeRegistry();
