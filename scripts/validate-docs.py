#!/usr/bin/env python3
"""
Validate documentation structure and completeness.
Checks that all required files exist and have proper structure.
"""

import os
import sys
from pathlib import Path

def validate_structure():
    """Validate the documentation folder structure."""
    docs_dir = Path("docs")
    
    if not docs_dir.exists():
        print("❌ docs/ directory not found")
        return False
    
    # Required files
    required_files = [
        "index.md",
        "getting-started.md",
        "installation.md",
        "usage.md",
        "customization.md",
        "helm-deployment.md",
        "git-workflows.md",
        "troubleshooting.md",
        "reference/commands.md",
    ]
    
    all_exist = True
    for file in required_files:
        file_path = docs_dir / file
        if file_path.exists():
            print(f"✓ {file}")
        else:
            print(f"✗ {file} - MISSING")
            all_exist = False
    
    return all_exist


def validate_mkdocs_config():
    """Validate mkdocs.yml configuration."""
    if not Path("mkdocs.yml").exists():
        print("❌ mkdocs.yml not found")
        return False
    
    print("✓ mkdocs.yml exists")
    return True


def validate_file_frontmatter():
    """Validate that markdown files have proper frontmatter."""
    docs_dir = Path("docs")
    issues = []
    
    for md_file in docs_dir.glob("**/*.md"):
        with open(md_file, 'r', encoding='utf-8') as f:
            content = f.read()
            
            # Check if file has content
            if len(content.strip()) == 0:
                issues.append(f"Empty file: {md_file}")
            
            # Check if has at least one heading
            if not any(line.startswith("#") for line in content.split("\n")):
                issues.append(f"No heading in: {md_file}")
    
    if issues:
        for issue in issues:
            print(f"⚠ {issue}")
        return False
    
    print(f"✓ {sum(1 for _ in docs_dir.glob('**/*.md'))} markdown files validated")
    return True


def main():
    """Run all validations."""
    print("Validating documentation structure...\n")
    
    checks = [
        ("MkDocs configuration", validate_mkdocs_config),
        ("Required files", validate_structure),
        ("File content", validate_file_frontmatter),
    ]
    
    results = []
    for check_name, check_func in checks:
        print(f"\n{check_name}:")
        results.append(check_func())
    
    print("\n" + "="*50)
    if all(results):
        print("✅ All documentation validations passed!")
        return 0
    else:
        print("❌ Some validations failed")
        return 1


if __name__ == "__main__":
    sys.exit(main())
