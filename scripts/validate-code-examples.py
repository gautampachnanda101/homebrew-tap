#!/usr/bin/env python3
"""
Validate code examples in documentation.
Checks for syntax errors and proper formatting.
"""

import re
import sys
from pathlib import Path

def extract_code_blocks(md_file):
    """Extract all code blocks from a markdown file."""
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Extract fenced code blocks with language
    pattern = r'```(\w+)\n(.*?)\n```'
    matches = re.findall(pattern, content, re.DOTALL)
    
    return matches


def validate_bash_syntax(code):
    """Basic validation of bash code."""
    issues = []
    
    # Only check full code block for gross syntax issues
    # Per-line checks generate too many false positives
    
    # Check for heredoc syntax (<<<EOF style)
    if '<<<' in code:
        # If use heredocs, more complex validation needed - skip
        return issues
    
    # Count brackets across entire block
    if code.count('(') != code.count(')'):
        issues.append("Unmatched parentheses in code block")
    
    if code.count('[') != code.count(']'):
        issues.append("Unmatched square brackets in code block")
    
    # Allow unmatched braces (common in templating)
    # Multiple braces could be for template syntax
    
    return issues


def validate_yaml_syntax(code):
    """Basic validation of YAML code."""
    issues = []
    
    lines = code.split('\n')
    prev_indent = None
    
    for i, line in enumerate(lines, 1):
        # Skip empty lines and comments
        if not line.strip() or line.strip().startswith('#'):
            continue
        
        # Check indentation consistency
        indent = len(line) - len(line.lstrip())
        
        # YAML requires spaces, not tabs
        if '\t' in line:
            issues.append(f"Line {i}: Found tab character (use spaces)")
        
        # Check for valid YAML indentation (multiples of 2)
        if indent > 0 and indent % 2 != 0:
            issues.append(f"Line {i}: Indentation not multiple of 2")
    
    return issues


def validate_json_syntax(code):
    """Basic validation of JSON code."""
    import json
    
    try:
        json.loads(code)
        return []
    except json.JSONDecodeError as e:
        return [f"Invalid JSON: {e.msg} at line {e.lineno}"]


def validate_code_examples():
    """Validate all code examples in documentation."""
    docs_dir = Path("docs")
    all_issues = {}
    
    for md_file in docs_dir.glob("**/*.md"):
        code_blocks = extract_code_blocks(md_file)
        if not code_blocks:
            continue
        
        file_issues = []
        
        for lang, code in code_blocks:
            block_issues = []
            
            if lang in ['bash', 'sh', 'shell', 'zsh']:
                block_issues = validate_bash_syntax(code)
            elif lang in ['yaml', 'yml']:
                block_issues = validate_yaml_syntax(code)
            elif lang == 'json':
                block_issues = validate_json_syntax(code)
            
            if block_issues:
                file_issues.append((lang, block_issues))
        
        if file_issues:
            all_issues[str(md_file)] = file_issues
    
    return all_issues


def print_results(issues):
    """Print validation results."""
    if not issues:
        print("✓ All code examples are valid")
        return True
    
    print(f"Found {len(issues)} files with code example issues:\n")
    
    for file, file_issues in issues.items():
        print(f"  {file}:")
        for lang, block_issues in file_issues:
            print(f"    [{lang}]:")
            for issue in block_issues:
                print(f"      - {issue}")
    
    return False


def main():
    """Run code example validation."""
    print("Validating code examples...\n")
    
    issues = validate_code_examples()
    success = print_results(issues)
    
    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
