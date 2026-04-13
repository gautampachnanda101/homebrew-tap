# Contributing to Homebrew Tap

Thank you for your interest in improving the Homebrew Tap!

## How You Can Help

### ✅ Ways to Contribute (Tap Repository)

This repository welcomes contributions in these areas:

1. **Examples** - Add or improve Kustomize recipes for deploying services into k3d clusters
2. **Documentation** - Enhance guides, tutorials, and reference materials
3. **Issue Reports** - Report bugs or request features for the tap itself
4. **Suggestions** - Propose improvements or new examples

### ⚠️ Package Formulas (Auto-Generated)

The formulas in `Formula/` are **automatically generated** from upstream releases:
- `k3d-local.rb` - Generated from [local-cluster-k3d releases](https://github.com/gautampachnanda101/local-cluster-k3d/releases)
- `promptx.rb` - Generated from [prompt-detective releases](https://github.com/gautampachnanda101/prompt-detective/releases)

**For package-specific issues or features:**
- These upstream projects are **private repositories**
- Issues related to k3d-local or Promptx packages should be reported **here** in the homebrew-tap repository
- The tap maintainer will coordinate with upstream as needed

---

## Contributing Examples to k3d-local

k3d-local examples are production-ready Kustomize recipes for deploying services into your k3d cluster.

### Add a New Example

1. **Create example directory:**
   ```bash
   mkdir -p examples/myservice/{base,overlays/{local,prod}}
   ```

2. **Create Kustomize structure:**
   ```bash
   # base/kustomization.yaml
   cat > examples/myservice/base/kustomization.yaml << 'EOF'
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   
   resources:
   - namespace.yaml
   - deployment.yaml
   - service.yaml
   EOF

   # base/namespace.yaml, deployment.yaml, service.yaml
   # Create your manifests...

   # overlays/local/kustomization.yaml
   cat > examples/myservice/overlays/local/kustomization.yaml << 'EOF'
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   
   bases:
   - ../../base
   EOF
   ```

3. **Create install script:**
   ```bash
   cat > examples/myservice/install.sh << 'EOF'
   #!/usr/bin/env bash
   set -euo pipefail
   
   ENVIRONMENT="local"
   NAMESPACE="myservice"
   
   echo "Installing MyService into k3d cluster..."
   kubectl apply -k overlays/${ENVIRONMENT}
   echo "MyService installed successfully!"
   EOF
   chmod +x examples/myservice/install.sh
   ```

4. **Add uninstall script:**
   ```bash
   cat > examples/myservice/uninstall.sh << 'EOF'
   #!/usr/bin/env bash
   set -euo pipefail
   
   kubectl delete namespace myservice
   echo "MyService uninstalled."
   EOF
   chmod +x examples/myservice/uninstall.sh
   ```

5. **Write README.md:**
   ```markdown
   # MyService
   
   Brief description of what this service does.
   
   ## Quick Start
   
   Prerequisites:
   - k3d-local cluster running
   - Traefik installed
   
   Install:
   \`\`\`bash
   ./install.sh
   \`\`\`
   ```

6. **Test your example:**
   ```bash
   # Create test cluster
   k3d-local create --with-traefik
   
   # Install your example
   cd examples/myservice
   ./install.sh
   
   # Verify
   kubectl get pods -n myservice
   
   # Uninstall
   ./uninstall.sh
   
   # Cleanup
   k3d-local delete
   ```

7. **Update examples/README.md:**
   Add your example to the list of available recipes

8. **Submit PR:**
   - Clear description of the service
   - Why it's useful for k3d users
   - Testing instructions
   - Links to upstream project documentation

---

# Contributing to Documentation

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

Thank you for improving the Homebrew Tap! Contributors are recognized by GitHub automatically in the repository.

### Contribution Types

| Type | Repository | Level of Help |
|------|-----------|---------------|
| **Documentation** | This repo (homebrew-tap) | 📖 Easy - Start here! |
| **Examples/Recipes** | This repo (homebrew-tap) | 🎯 Moderate - Requires k3d knowledge |
| **Package Features** | Private upstream repos | 🔒 Contact maintainer |
| **Bug Reports** | This repo (homebrew-tap) | 🐛 All levels welcome |

---

## Repository Access & Protections

The `main` branch has protections to ensure code quality:

### Branch Protection Rules
- **1 approval required** - PRs need review before merging
- **Force pushes blocked** - Prevents accidental history rewrites
- **Deletions blocked** - Protects main branch from removal
- **Enforce admins** - Rules apply even to repository owner

### Who Can Merge?
- **External contributors** - Submit PRs, wait for review + 1 approval
- **Repository owner** - Can merge PRs and push directly (for hotfixes/urgent updates)
- **Upstream automation** - GoReleaser can push formula updates directly via GitHub Actions

### Setting Up Branch Protection (Maintainers)

To enable branch protection:

```bash
# Run the automation script
make setup-branch-protection

# Or manually via GitHub UI:
# 1. Go to Settings → Branches
# 2. Click "Add rule" for main branch
# 3. Enable: Require pull request reviews (1 approval)
# 4. Enable: Dismiss stale pull request approvals
# 5. Enable: Restrict who can push (optional)
# 6. Save
```

The script in `scripts/setup-branch-protection.sh` automates this configuration.

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn
- Report issues professionally
- No harassment or discrimination
