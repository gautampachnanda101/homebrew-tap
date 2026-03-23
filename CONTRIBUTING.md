# Contributing to Homebrew Tap Documentation

Thank you for your interest in improving the documentation for the Homebrew Tap!

## Documentation Structure

The documentation follows [Backstage conventions](https://backstage.io/) with:

- **Lowercase filenames** - All markdown files use lowercase (e.g., `getting-started.md`)
- **MkDocs Material theme** - Modern, responsive documentation site
- **Organized by user journey** - Getting started → Installation → Usage → Advanced → Reference

## Making Documentation Changes

### 1. Set Up Locally

```bash
# Clone repository
git clone https://github.com/gautampachnanda101/homebrew-tap.git
cd homebrew-tap

# Install documentation tools
make install-docs-deps

# Serve locally
make serve-docs
```

Browse to `http://localhost:8000` to see your changes in real-time.

### 2. Edit Documentation

Edit files in the `docs/` folder:

```bash
# Example: Update getting started guide
vim docs/getting-started.md

# Example: Add new advanced guide
cat > docs/advanced-helm.md << 'EOF'
# Advanced Helm Usage

...
EOF
```

### 3. Validate Changes

Before committing, validate:

```bash
# Run all validation checks locally
make test-docs

# Or individually:
python3 scripts/validate-docs.py
python3 scripts/lint-markdown.py
python3 scripts/validate-code-examples.py
python3 scripts/check-links.py
```

All checks must pass:
```
✅ All documentation validations passed!
✓ No markdown issues found
✓ All code examples are valid
✓ No broken internal links found
```

### 4. Commit and Push

```bash
# Create feature branch
git checkout -b docs/your-change-description

# Commit with clear message
git add docs/
git commit -m "docs: describe your changes

- Explain what was added/changed
- Add any relevant context
- Reference issues if applicable"

# Push to GitHub
git push origin docs/your-change-description
```

### 5. Create Pull Request

[Open a PR](https://github.com/gautampachnanda101/homebrew-tap/pulls) with:

- **Clear description** of changes
- **Link to any issues** you're addressing
- **Screenshots** if adding UI elements
- **Testing commands** if adding new features

GitHub Actions will:
- ✅ Validate the documentation
- ✅ Upload preview artifact
- ✅ Run all checks

### 6. Merge and Publish

Once approved and checks pass:
1. Maintainer merges PR
2. Push to `main` automatically triggers publication
3. Documentation updates live within 1-2 minutes

## Documentation Guidelines

### Writing Style

✅ **DO:**
- Write for users of the tap (not developers)
- Use clear, simple language
- Include practical examples
- Explain the "why" not just the "how"
- Test all code examples

❌ **DON'T:**
- Use jargon without explanation
- Include outdated information
- Skip error handling examples
- Assume reader knowledge

### Code Examples

All code examples are validated, so ensure they work:

```bash
# ✅ Good - tested and working
k3d-local create --with-traefik

# ❌ Bad - incomplete or untested
k3d-local create #install traefik
```

### External Links

For external resources:
```markdown
See [Helm Documentation](https://helm.sh/docs/)
```

For internal references:
```markdown
See [Installation Guide](installation.md)
See [Commands Reference](reference/commands.md#create)
```

### File Structure

Keep docs organized:

```
docs/
├── index.md                 # Homepage/overview
├── getting-started.md       # Quick start (5 minutes)
├── installation.md          # Platform-specific install
├── usage.md                 # Common workflows
├── customization.md         # How to extend
├── helm-deployment.md       # Helm guide
├── git-workflows.md         # Git/team patterns
├── troubleshooting.md       # Solutions
└── reference/
    └── commands.md          # CLI reference
```

## Code Example Standards

### Shell Commands

```bash
# Good - clear, tested, shows output
k3d-local create
kubectl get pods
```

### Kubernetes Manifests

```yaml
# Good - complete, valid manifest
apiVersion: v1
kind: Pod
metadata:
  name: example
spec:
  containers:
  - name: main
    image: nginx:latest
```

### Multi-step workflows

```bash
# Good - numbered, explains each step
# 1. Create cluster
k3d-local create

# 2. Deploy application
kubectl apply -f app.yaml

# 3. Verify
kubectl get pods
```

## Validation Checks

All documentation is automatically validated for:

| Check | What it Tests | Fail Criteria |
|-------|---------------|---------------|
| **Structure** | Required files exist | Missing main docs files |
| **Markdown** | Link formatting | Broken links, malformed refs |
| **Code Examples** | Bash/YAML/JSON syntax | Invalid syntax in code blocks |
| **Links** | Internal references | Target files/anchors don't exist |
| **Config** | mkdocs.yml | Missing or invalid config |
| **Spelling** | Common typos | Misspelled words |

## Troubleshooting Documentation Issues

### Validation Fails Locally

```bash
# Run verbose validation
python3 scripts/validate-docs.py
python3 scripts/check-links.py

# Check specific file
grep "broken-link" docs/*.md
```

### Code Examples Don't Work

Test code examples in actual local cluster:

```bash
# Create test cluster
k3d-local delete
k3d-local create --with-traefik

# Run example commands
kubectl apply -f docs/example.yaml
kubectl get pods
```

### Links Are Broken

Internal links must use relative paths:

```markdown
# ❌ Wrong
[Guide](../docs/installation.md)

# ✅ Correct
[Guide](installation.md)
[Command](reference/commands.md)
[Section](installation.md#macos)
```

## Publishing Workflow

```
Your Changes
    ↓
Feature Branch (docs/...)
    ↓
GitHub Pull Request
    ↓
CI Validation (docs-validate.yml) ← Runs all checks
    ↓
Code Review + Approval
    ↓
Merge to main
    ↓
CI Publish (docs-publish.yml) ← Auto-deploy
    ↓
Live on GitHub Pages
```

## Getting Help

Need assistance?

- **Validation questions** - See [scripts/README.md](scripts/README.md)
- **MkDocs issues** - Check [MkDocs docs](https://www.mkdocs.org/)
- **GitHub Pages help** - See [GitHub Pages guide](https://pages.github.com/)
- **General questions** - [Open an issue](https://github.com/gautampachnanda101/homebrew-tap/issues)

## Recognition

Thank you for improving the documentation! Contributors are recognized by GitHub automatically in the repository.

---

**Ready to contribute?** 
1. Fork the repository
2. Make your changes
3. Run `make test-docs`
4. Submit a pull request!
