.PHONY: help install-docs-deps build-docs serve-docs publish-docs clean-docs test-docs install-pre-commit-hook run-pre-commit-hook setup-branch-protection

MKDOCS_VERSION ?= 1.6.1
MKDOCS_MATERIAL_VERSION ?= 9.6.23
PYMDOWN_EXTENSIONS_VERSION ?= 10.21.2

help:
	@echo "Homebrew Tap Documentation & Publishing Tasks"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install-docs-deps         Install pinned documentation dependencies"
	@echo "  build-docs                Build documentation site locally"
	@echo "  serve-docs                Serve docs locally at http://localhost:8000"
	@echo "  publish-docs              Build and publish to GitHub Pages (main branch)"
	@echo "  test-docs                 Validate markdown and links"
	@echo "  install-pre-commit-hook   Configure local Git pre-commit hook from .githooks/"
	@echo "  run-pre-commit-hook       Run pre-commit checks now"
	@echo "  clean-docs                Remove generated docs artifacts"
	@echo "  setup-branch-protection   Enable branch protection rules on main branch"
	@echo ""

# Install documentation dependencies
install-docs-deps:
	@echo "Installing pinned documentation dependencies..."
	@echo "  mkdocs==$(MKDOCS_VERSION)"
	@echo "  mkdocs-material==$(MKDOCS_MATERIAL_VERSION)"
	@echo "  pymdown-extensions==$(PYMDOWN_EXTENSIONS_VERSION)"
	python3 -m pip install --upgrade pip
	python3 -m pip install \
		"mkdocs==$(MKDOCS_VERSION)" \
		"mkdocs-material==$(MKDOCS_MATERIAL_VERSION)" \
		"pymdown-extensions==$(PYMDOWN_EXTENSIONS_VERSION)"

# Build documentation
build-docs:
	@echo "Building documentation..."
	python3 -m mkdocs build
	@echo "✓ Documentation built in ./site/"

# Serve documentation locally
serve-docs:
	@echo "Serving documentation at http://localhost:8000"
	@echo "Press Ctrl+C to stop"
	python3 -m mkdocs serve

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
	python3 -m mkdocs build
	@echo "Deploying to gh-pages branch..."
	python3 -m mkdocs gh-deploy --force
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
	python3 -m mkdocs build --strict
	@echo ""
	@echo "✅ All documentation tests passed!"

# Install repository-managed pre-commit hook
install-pre-commit-hook:
	@echo "Installing repository pre-commit hook..."
	@if [ ! -f .githooks/pre-commit ]; then \
		echo "Error: .githooks/pre-commit not found"; \
		exit 1; \
	fi
	@git config core.hooksPath .githooks
	@chmod +x .githooks/pre-commit
	@echo "Pre-commit hook installed via core.hooksPath=.githooks"

# Run pre-commit hook checks manually
run-pre-commit-hook:
	@.githooks/pre-commit

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
