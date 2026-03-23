#!/usr/bin/env python3
"""
Check for broken links in documentation.
Validates internal markdown links and references.
"""

import re
import sys
from pathlib import Path
from urllib.parse import urlparse

def extract_links(md_file):
    """Extract all links from a markdown file."""
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Find markdown links [text](url)
    links = re.findall(r'\[([^\]]+)\]\(([^)]+)\)', content)
    
    # Find reference-style links [text][ref]
    refs = re.findall(r'\[([^\]]+)\]\[([^\]]+)\]', content)
    
    return links, refs


def validate_internal_links():
    """Validate internal link references."""
    docs_dir = Path("docs")
    broken_links = []
    
    for md_file in sorted(docs_dir.glob("**/*.md")):
        links, refs = extract_links(md_file)
        
        for text, link in links:
            # Skip external links
            if link.startswith(('http://', 'https://', 'mailto:', 'ftp://')):
                continue
            
            # Handle anchor links (#)
            if link.startswith('#'):
                # For now, assume anchors are valid (would need parsing to properly validate)
                continue
            
            # Handle relative links
            if link.startswith('.') or not link.startswith('/'):
                # Resolve relative to current file
                target = md_file.parent / link
                target = target.resolve()
                
                # Check if target exists (ignore anchors)
                target_path = str(target).split('#')[0]
                if not Path(target_path).exists():
                    broken_links.append({
                        'file': str(md_file),
                        'link': link,
                        'type': 'broken',
                        'target': target_path
                    })
    
    return broken_links


def validate_anchors():
    """Validate that headings exist for anchor links."""
    docs_dir = Path("docs")
    issues = []
    
    # Build a map of all headings
    headings_map = {}
    
    for md_file in docs_dir.glob("**/*.md"):
        with open(md_file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Extract all headings
        heading_pattern = r'^#{1,6}\s+(.+)$'
        for match in re.finditer(heading_pattern, content, re.MULTILINE):
            heading_text = match.group(1).strip()
            # Convert to anchor format (lowercase, spaces to hyphens)
            anchor = heading_text.lower().replace(' ', '-').replace('/', '-')
            headings_map[anchor] = {
                'file': str(md_file),
                'text': heading_text
            }
    
    # Check anchor links
    for md_file in docs_dir.glob("**/*.md"):
        links, _ = extract_links(md_file)
        
        for text, link in links:
            if '#' in link and not link.startswith('http'):
                anchor = link.split('#')[1].lower()
                if anchor not in headings_map:
                    issues.append({
                        'file': str(md_file),
                        'anchor': f"#{anchor}",
                        'text': text
                    })
    
    return issues


def print_results(broken_links, anchor_issues):
    """Print validation results."""
    success = True
    
    if broken_links:
        print(f"❌ Found {len(broken_links)} broken links:\n")
        for item in broken_links:
            print(f"  {item['file']}")
            print(f"    Link: {item['link']}")
            print(f"    Target: {item['target']}")
        success = False
    else:
        print("✓ No broken internal links found")
    
    if anchor_issues:
        print(f"\n⚠ Found {len(anchor_issues)} invalid anchors:\n")
        for item in anchor_issues:
            print(f"  {item['file']}")
            print(f"    Anchor: {item['anchor']} (from '{item['text']}')")
        # Anchors warnings only - not fatal
    else:
        print("✓ All anchor links valid")
    
    return success


def main():
    """Run link validation."""
    print("Checking documentation links...\n")
    
    broken_links = validate_internal_links()
    anchor_issues = validate_anchors()
    
    success = print_results(broken_links, anchor_issues)
    
    return 0 if success else 1


if __name__ == "__main__":
    sys.exit(main())
