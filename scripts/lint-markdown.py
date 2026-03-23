#!/usr/bin/env python3
"""
Lint markdown files for common issues.
"""

import os
import sys
from pathlib import Path
import re

def check_markdown_files():
    """Check markdown files for common issues."""
    docs_dir = Path("docs")
    issues = []
    
    for md_file in docs_dir.glob("**/*.md"):
        with open(md_file, 'r', encoding='utf-8') as f:
            content = f.read()
            lines = content.split("\n")
        
        # Check for proper code block formatting
        if "```" in content:
            code_blocks = content.count("```")
            if code_blocks % 2 != 0:
                issues.append(f"{md_file} - Unmatched code block delimiters")
        
        # Check for broken markdown links
        links = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', content)
        for text, link in links:
            # Check if it's a relative link and exists
            if not link.startswith(('http://', 'https://', '#')):
                # It's a relative link
                target = (md_file.parent / link).resolve()
                if not target.exists() and '#' not in str(link):
                    issues.append(f"{md_file} - Broken link: {link}")
    
    
    return issues


def print_results(issues):
    """Print linting results."""
    if not issues:
        print("✓ No markdown issues found")
        return True
    
    print(f"Found {len(issues)} markdown issues:\n")
    for issue in issues:
        print(f"  ⚠ {issue}")
    
    return False


def main():
    """Run markdown linting."""
    print("Linting markdown files...\n")
    
    issues = check_markdown_files()
    success = print_results(issues)
    
    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
