#!/usr/bin/env python3
"""
Validation script for machine-learning skill.
Category: general
"""

import os
import sys
import yaml
import json
from pathlib import Path


def validate_config(config_path: str) -> dict:
    """
    Validate skill configuration file.

    Args:
        config_path: Path to config.yaml

    Returns:
        dict: Validation result with 'valid' and 'errors' keys
    """
    errors = []

    if not os.path.exists(config_path):
        return {"valid": False, "errors": ["Config file not found"]}

    try:
        with open(config_path, 'r') as f:
            config = yaml.safe_load(f)
    except yaml.YAMLError as e:
        return {"valid": False, "errors": [f"YAML parse error: {e}"]}

    # Validate required fields
    if 'skill' not in config:
        errors.append("Missing 'skill' section")
    else:
        if 'name' not in config['skill']:
            errors.append("Missing skill.name")
        if 'version' not in config['skill']:
            errors.append("Missing skill.version")

    # Validate settings
    if 'settings' in config:
        settings = config['settings']
        if 'log_level' in settings:
            valid_levels = ['debug', 'info', 'warn', 'error']
            if settings['log_level'] not in valid_levels:
                errors.append(f"Invalid log_level: {settings['log_level']}")

    return {
        "valid": len(errors) == 0,
        "errors": errors,
        "config": config if not errors else None
    }


def validate_skill_structure(skill_path: str) -> dict:
    """
    Validate skill directory structure.

    Args:
        skill_path: Path to skill directory

    Returns:
        dict: Structure validation result
    """
    required_dirs = ['assets', 'scripts', 'references']
    required_files = ['SKILL.md']

    errors = []

    # Check required files
    for file in required_files:
        if not os.path.exists(os.path.join(skill_path, file)):
            errors.append(f"Missing required file: {file}")

    # Check required directories
    for dir in required_dirs:
        dir_path = os.path.join(skill_path, dir)
        if not os.path.isdir(dir_path):
            errors.append(f"Missing required directory: {dir}/")
        else:
            # Check for real content (not just .gitkeep)
            files = [f for f in os.listdir(dir_path) if f != '.gitkeep']
            if not files:
                errors.append(f"Directory {dir}/ has no real content")

    return {
        "valid": len(errors) == 0,
        "errors": errors,
        "skill_name": os.path.basename(skill_path)
    }


def main():
    """Main validation entry point."""
    skill_path = Path(__file__).parent.parent

    print(f"Validating machine-learning skill...")
    print(f"Path: {skill_path}")

    # Validate structure
    structure_result = validate_skill_structure(str(skill_path))
    print(f"\nStructure validation: {'PASS' if structure_result['valid'] else 'FAIL'}")
    if structure_result['errors']:
        for error in structure_result['errors']:
            print(f"  - {error}")

    # Validate config
    config_path = skill_path / 'assets' / 'config.yaml'
    if config_path.exists():
        config_result = validate_config(str(config_path))
        print(f"\nConfig validation: {'PASS' if config_result['valid'] else 'FAIL'}")
        if config_result['errors']:
            for error in config_result['errors']:
                print(f"  - {error}")
    else:
        print("\nConfig validation: SKIPPED (no config.yaml)")

    # Summary
    all_valid = structure_result['valid']
    print(f"\n==================================================")
    print(f"Overall: {'VALID' if all_valid else 'INVALID'}")

    return 0 if all_valid else 1


if __name__ == "__main__":
    sys.exit(main())
