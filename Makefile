.PHONY: help install-docs-deps build-docs serve-docs publish-docs clean-docs test-docs setup-branch-protection

help:
	@echo "Homebrew Tap Documentation & Publishing Tasks"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install-docs-deps         Install documentation dependencies (pip, mkdocs)"
	@echo "  build-docs                Build documentation site locally"
	@echo "  serve-docs                Serve docs locally at http://localhost:8000"
	@echo "  publish-docs              Build and publish to GitHub Pages (main branch)"
	@echo "  test-docs                 Validate markdown and links"
	@echo "  clean-docs                Remove generated docs artifacts"
	@echo "  setup-branch-protection   Enable branch protection rules on main branch"
	@echo ""

# Install documentation dependencies
install-docs-deps:
	@echo "Installing MkDocs and dependencies..."
	python3 -m pip install --upgrade pip
	python3 -m pip install mkdocs mkdocs-material pymdown-extensions

# Build documentation
build-docs:
	@echo "Building documentation..."
	mkdocs build
	@echo "✓ Documentation built in ./site/"

# Serve documentation locally
serve-docs:
	@echo "Serving documentation at http://localhost:8000"
	@echo "Press Ctrl+C to stop"
	mkdocs serve

# Publish documentation to GitHub Pages
publish-docs:
	@echo "Publishing documentation to GitHub Pages..."
	@if [ -z "$(shell git config --get remote.origin.url)" ]; then \
		echo "✗ Error: Not a git repository or no remote configured"; \
		exit 1; \
	fi
	@if [ -n "$(shell git status --porcelain)" ]; then \
		echo "✗ Error: Working directory has uncommitted changes"; \
		echo "  Please commit or stash changes before publishing"; \
		exit 1; \
	fi
	@echo "Building documentation..."
	mkdocs build
	@echo "Deploying to gh-pages branch..."
	mkdocs gh-deploy --force
	@echo ""
	@echo "✓ Documentation published successfully!"
	@echo "  View at: https://$(shell basename `git config --get remote.origin.url` .git).github.io/"
	@echo ""

# Test documentation
test-docs:
	@echo "Testing documentation..."
	@echo ""
	@echo "1. Validating documentation structure..."
	python3 scripts/validate-docs.py
	@echo ""
	@echo "2. Linting markdown files..."
	python3 scripts/lint-markdown.py
	@echo ""
	@echo "3. Validating code examples..."
	python3 scripts/validate-code-examples.py
	@echo ""
	@echo "4. Checking links..."
	python3 scripts/check-links.py
	@echo ""
	@echo "5. Building documentation..."
	mkdocs build --strict
	@echo ""
	@echo "✅ All documentation tests passed!"

# Clean generated artifacts
clean-docs:
	@echo "Cleaning documentation artifacts..."
	rm -rf site/
	@echo "✓ Cleaned"

# Setup branch protection on main branch
setup-branch-protection:
	@echo "Setting up branch protection on main branch..."
	@if [ ! -f scripts/setup-branch-protection.sh ]; then \
		echo "✗ Error: scripts/setup-branch-protection.sh not found"; \
		exit 1; \
	fi
	@chmod +x scripts/setup-branch-protection.sh
	@bash scripts/setup-branch-protection.sh
