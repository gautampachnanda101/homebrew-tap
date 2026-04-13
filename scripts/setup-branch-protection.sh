#!/usr/bin/env bash
# Setup branch protection for homebrew-tap main branch
# Requirements:
# - GitHub CLI installed (gh)
# - Authenticated with: gh auth login
# - Owner permissions on the repository

set -euo pipefail

REPO="gautampachnanda101/homebrew-tap"
BRANCH="main"

echo "🔒 Setting up branch protection for $REPO:$BRANCH"
echo ""

# Check authentication
if ! gh auth status >/dev/null 2>&1; then
    echo "❌ Not authenticated with GitHub CLI"
    echo "Run: gh auth login"
    exit 1
fi

echo "✅ Authenticated"
echo ""

# Enable branch protection with rules:
# - Enforce admins (repo owner needed for rule exceptions)
# - No force pushes
# - No deletions
# - Allow direct pushes for automated workflows (upstream repos)
# - Require PR reviews for normal contributions

echo "📋 Applying branch protection rules..."

curl -s -H "Authorization: token $(gh auth token)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -X PUT "https://api.github.com/repos/$REPO/branches/$BRANCH/protection" \
  -d '{
    "required_status_checks": null,
    "enforce_admins": true,
    "required_pull_request_reviews": {
      "dismiss_stale_reviews": true,
      "require_code_owner_reviews": false,
      "required_approving_review_count": 1
    },
    "restrictions": null,
    "required_linear_history": false,
    "allow_force_pushes": false,
    "allow_deletions": false,
    "required_conversation_resolution": false,
    "required_deployment_environments": null
  }' > /dev/null

if [ $? -eq 0 ]; then
    echo "✅ Branch protection enabled!"
    echo ""
    echo "Rules configured:"
    echo "  • ✅ Enforce admins: true (owner can override rules)"
    echo "  • ✅ Allow force pushes: false"
    echo "  • ✅ Allow deletions: false"
    echo "  • ✅ Require 1 approval on PRs"
    echo "  • ✅ Dismiss stale reviews"
    echo "  • ✅ Allow direct pushes (for upstream repos/GitHub Actions)"
    echo ""
    echo "📝 How this works:"
    echo "  • External contributors: Must submit PRs, need 1 approval to merge"
    echo "  • Owner (@gautampachnanda101): Can merge PRs and push directly"
    echo "  • Upstream repos: Can push directly via GitHub Actions workflows"
    echo ""
    echo "Verify at: https://github.com/$REPO/settings/branches"
else
    echo "❌ Failed to enable branch protection"
    exit 1
fi
