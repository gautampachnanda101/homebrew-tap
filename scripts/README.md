# Documentation CI/CD Pipeline

This directory contains scripts and workflows for validating and publishing documentation.

## Overview

The documentation is validated and published using:

- **GitHub Actions workflows** - Automated CI/CD on every push/PR
- **Python validation scripts** - Local testing and validation
- **MkDocs** - Static site generation and deployment

## GitHub Actions Workflows

### 1. `docs-validate.yml` - On Every PR and Push

**Triggers:** Pull requests and pushes to `main`/`develop` that touch `docs/`

**Checks performed:**
- ✅ MkDocs configuration validation
- ✅ Documentation structure (required files present)
- ✅ Markdown syntax linting
- ✅ Code example validation (bash, YAML, JSON)
- ✅ Internal link checking
- ✅ YAML syntax validation
- ✅ Spell checking

**Artifacts:** Generated site uploaded for preview (7-day retention)

### 2. `docs-publish.yml` - Deploy on Main Branch

**Triggers:** Pushes to `main` that touch `docs/`

**Actions:**
- ✅ Runs all validation checks
- ✅ Builds documentation with MkDocs
- ✅ Deploys to GitHub Pages automatically
- ✅ Updates GH Pages branch with built site

**Access:** Published at `https://<username>.github.io/homebrew-tap/`

## Local Validation Scripts

All scripts are Python 3 and can be run locally:

### `validate-docs.py`
Validates documentation structure and completeness.

```bash
python3 scripts/validate-docs.py
```

**Checks:**
- Required files exist
- All markdown files have content
- mkdocs.yml properly configured

### `lint-markdown.py`
Lints markdown files for formatting issues.

```bash
python3 scripts/lint-markdown.py
```

**Checks:**
- Unmatched code blocks
- Broken links
- File content validation

### `validate-code-examples.py`
Validates bash, YAML, and JSON code examples.

```bash
python3 scripts/validate-code-examples.py
```

**Checks:**
- Bash/shell syntax validation
- YAML/Kubernetes manifest syntax
- JSON syntax validation
- Common bash mistakes

### `check-links.py`
Validates internal and anchor links.

```bash
python3 scripts/check-links.py
```

**Checks:**
- Relative link targets exist
- Anchor references are valid
- No broken references

### `validate-yaml.py`
Deep YAML validation using PyYAML (optional).

```bash
python3 scripts/validate-yaml.py
```

**Requires:** `pip install PyYAML`

## Running Locally

### Quick Test - All Validators

```bash
# Run all validation scripts
make test-docs
```

### Individual Validators

```bash
python3 scripts/validate-docs.py
python3 scripts/lint-markdown.py
python3 scripts/validate-code-examples.py
python3 scripts/check-links.py
```

### Serve Docs Locally

```bash
# Install dependencies
make install-docs-deps

# Serve at http://localhost:8000
make serve-docs

# Build static site
make build-docs
```

### Publish to GitHub Pages

```bash
# Validate, build, and deploy
make publish-docs
```

**Requirements:**
- Clean working directory (no uncommitted changes)
- Proper git remote configured
- GitHub Pages enabled on repository
- GitHub token with write permissions

## CI/CD Workflow

### When You Make Changes to Docs

1. **Edit documentation files** in `docs/`
   ```bash
   # Create feature branch
   git checkout -b docs/improve-guide
   # Edit docs
   vim docs/customization.md
   ```

2. **Test locally**
   ```bash
   # Validate all checks pass
   make test-docs
   
   # Or individually
   python3 scripts/validate-docs.py
   python3 scripts/lint-markdown.py
   ```

3. **Commit and push**
   ```bash
   git add docs/
   git commit -m "docs: improve customization guide"
   git push origin docs/improve-guide
   ```

4. **GitHub Actions validates** (docs-validate.yml)
   - Runs on PR
   - Shows results as PR check
   - Uploads artifact with preview

5. **Merge to main**
   - Pass all PR checks
   - Get approved
   - Merge to main

6. **GitHub Actions publishes** (docs-publish.yml)
   - Automatically triggers
   - Validates documentation
   - Deploys to GitHub Pages
   - Site updates within 1-2 minutes

## Validation Results

### Success Example

```
✅ All documentation validations passed!

MkDocs configuration: ✓
Documentation build: ✓
Structure validation: ✓
Markdown syntax: ✓
Code examples: ✓
Internal links: ✓

Ready for publication!
```

### Failure Example

```
❌ Validation failed

docs/installation.md - Broken link: ./nonexistent.md
docs/usage.md:45 - Unmatched code block
```

**Fix by:**
1. Addressing the issues
2. Running local validation
3. Commit and push
4. CI re-validates automatically

## Customization

### Add to CI Validation

Edit `.github/workflows/docs-validate.yml`:

```yaml
- name: Custom check
  run: |
    echo "Running custom check..."
    python3 scripts/custom-validator.py
```

### Modify Validation Rules

Edit corresponding script in `scripts/`:

```python
# Example: scripts/validate-code-examples.py
def validate_bash_syntax(code):
    # Add custom validation logic
    pass
```

### Configure GitHub Pages URL

Set `DOCS_CNAME` secret in repository settings if using custom domain:

```bash
# GitHub Settings → Secrets → Repository secrets
# Add: DOCS_CNAME = docs.example.com
```

## Troubleshooting

### CI Validation Fails

1. **Check error message in GitHub Actions log**
2. **Run locally to reproduce:**
   ```bash
   python3 scripts/validate-docs.py
   ```
3. **Fix the issues**
4. **Commit and re-push** - CI automatically re-runs

### Docs Won't Deploy

**Check:**
- [ ] All validation checks pass
- [ ] mkdocs.yml is valid
- [ ] You're pushing to `main` branch
- [ ] docs folder has actual changes
- [ ] GitHub Pages enabled in repo settings

**Manually publish:**
```bash
make publish-docs
```

### Link Validation Too Strict

Modify `scripts/check-links.py` to adjust:
- External URL checking
- Anchor validation rules
- Path resolution logic

## Best Practices

✅ **DO:**
- Run local validation before pushing
- Keep test scripts updated
- Document validation requirements
- Use meaningful commit messages

❌ **DON'T:**
- Skip validation checks
- Push directly to main without PR
- Remove validation files
- Ignore CI failures

## Resources

- [MkDocs Documentation](https://www.mkdocs.org/)
- [GitHub Pages Guide](https://pages.github.com/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Markdown Guide](https://www.markdownguide.org/)

## Questions?

See main [README.md](../README.md) for project overview and contribution guidelines.
