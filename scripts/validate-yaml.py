#!/usr/bin/env python3
"""
Validate YAML code examples in documentation.
Ensures YAML syntax is correct.
"""

import re
import sys
from pathlib import Path

try:
    import yaml
    HAS_YAML = True
except ImportError:
    HAS_YAML = False


def extract_yaml_blocks(md_file):
    """Extract all YAML code blocks from a markdown file."""
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract YAML code blocks
    pattern = r'```(?:yaml|yml)\n(.*?)\n```'
    matches = re.findall(pattern, content, re.DOTALL)
    
    return matches


def validate_yaml_syntax(yaml_string):
    """Validate YAML syntax using PyYAML if available."""
    if not HAS_YAML:
        return []
    
    try:
        yaml.safe_load(yaml_string)
        return []
    except yaml.YAMLError as e:
        return [str(e)]


def validate_k8s_manifests():
    """Validate Kubernetes manifest examples."""
    docs_dir = Path("docs")
    all_issues = {}
    
    for md_file in docs_dir.glob("**/*.md"):
        yaml_blocks = extract_yaml_blocks(md_file)
        if not yaml_blocks:
            continue
        
        file_issues = []
        
        for yaml_content in yaml_blocks:
            issues = validate_yaml_syntax(yaml_content)
            if issues:
                file_issues.append(issues)
        
        if file_issues:
            all_issues[str(md_file)] = file_issues
    
    return all_issues


def print_results(issues):
    """Print validation results."""
    if HAS_YAML:
        if not issues:
            print("✓ All YAML examples are valid")
            return True
        
        print(f"Found {len(issues)} files with YAML issues:\n")
        
        for file, file_issues in issues.items():
            print(f"  {file}:")
            for block_issues in file_issues:
                for issue in block_issues:
                    print(f"    - {issue}")
        
        return False
    else:
        print("⚠ PyYAML not installed - skipping YAML validation")
        print("  Install with: pip install PyYAML")
        return True


def main():
    """Run YAML validation."""
    print("Validating YAML examples in documentation...\n")
    
    if not HAS_YAML:
        print("⚠ PyYAML not installed - YAML validation skipped")
        return 0
    
    issues = validate_k8s_manifests()
    success = print_results(issues)
    
    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
