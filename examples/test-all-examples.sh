#!/usr/bin/env bash
set -euo pipefail

# Comprehensive test script for all examples
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log_section() {
    echo ""
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${CYAN}  $1${NC}"
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${NC}"
    echo ""
}

log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_step() {
    echo -e "${BLUE}➜${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Track results
declare -a PASSED_TESTS=()
declare -a FAILED_TESTS=()

discover_examples() {
    local dir
    for dir in "$SCRIPT_DIR"/*; do
        if [ -d "$dir" ] && [ -f "$dir/install.sh" ]; then
            basename "$dir"
        fi
    done
}

test_base_syntax() {
    local example=$1
    local base_dir="$SCRIPT_DIR/$example/base"

    if [ ! -d "$base_dir" ]; then
        log_warn "$example: base directory missing, skipping"
        return 0
    fi

    log_step "Testing $example base..."
    if kustomize build "$base_dir" > /dev/null 2>&1; then
        log_info "$example base: Syntax valid"
        PASSED_TESTS+=("$example-base-syntax")
        return 0
    else
        log_error "$example base: Syntax invalid"
        FAILED_TESTS+=("$example-base-syntax")
        return 1
    fi
}

test_kustomize_syntax() {
    local example=$1
    local overlay=$2
    
    log_step "Testing $example $overlay overlay..."
    if kustomize build "$SCRIPT_DIR/$example/overlays/$overlay" > /dev/null 2>&1; then
        log_info "$example $overlay: Syntax valid"
        PASSED_TESTS+=("$example-$overlay-syntax")
        return 0
    else
        log_error "$example $overlay: Syntax invalid"
        FAILED_TESTS+=("$example-$overlay-syntax")
        return 1
    fi
}

test_argocd_full() {
    log_section "Full Integration Test: ArgoCD"
    
    cd "$SCRIPT_DIR/argocd"
    
    if [ ! -x "./test-local.sh" ]; then
        log_error "test-local.sh not executable"
        FAILED_TESTS+=("argocd-integration")
        return 1
    fi
    
    if ./test-local.sh; then
        log_info "ArgoCD integration test passed"
        PASSED_TESTS+=("argocd-integration")
        return 0
    else
        log_error "ArgoCD integration test failed"
        FAILED_TESTS+=("argocd-integration")
        return 1
    fi
}

check_prerequisites() {
    log_section "Checking Prerequisites"
    
    local missing=()
    
    if ! command -v kustomize &>/dev/null; then
        missing+=("kustomize")
    fi
    
    if ! command -v k3d-local &>/dev/null; then
        log_warn "k3d-local not found (needed for full integration test)"
    fi
    
    if ! command -v kubectl &>/dev/null; then
        log_warn "kubectl not found (needed for full integration test)"
    fi
    
    if [ ${#missing[@]} -gt 0 ]; then
        log_error "Missing required tools: ${missing[*]}"
        echo ""
        echo "Install with:"
        echo "  # kustomize"
        echo "  curl -s \"https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh\" | bash"
        echo "  sudo mv kustomize /usr/local/bin/"
        exit 1
    fi
    
    log_info "Prerequisites satisfied"
}

display_summary() {
    log_section "Test Summary"
    
    echo ""
    if [ ${#PASSED_TESTS[@]} -gt 0 ]; then
        echo -e "${GREEN}${BOLD}Passed Tests (${#PASSED_TESTS[@]}):${NC}"
        for test in "${PASSED_TESTS[@]}"; do
            echo -e "  ${GREEN}✓${NC} $test"
        done
    fi
    
    echo ""
    if [ ${#FAILED_TESTS[@]} -gt 0 ]; then
        echo -e "${RED}${BOLD}Failed Tests (${#FAILED_TESTS[@]}):${NC}"
        for test in "${FAILED_TESTS[@]}"; do
            echo -e "  ${RED}✗${NC} $test"
        done
        echo ""
        echo -e "${RED}${BOLD}❌ Some tests failed${NC}"
        return 1
    else
        echo -e "${GREEN}${BOLD}✅ All tests passed!${NC}"
        return 0
    fi
}

# Main execution
main() {
    log_section "Testing All Examples"
    
    check_prerequisites
    
    # Test kustomize syntax for all examples and overlays
    log_section "Kustomize Syntax Validation"

    local examples=()
    while IFS= read -r example; do
        examples+=("$example")
    done < <(discover_examples)

    if [ ${#examples[@]} -eq 0 ]; then
        log_error "No examples found"
        exit 1
    fi

    log_info "Discovered examples: ${examples[*]}"

    for example in "${examples[@]}"; do
        test_base_syntax "$example" || true

        local overlays_dir="$SCRIPT_DIR/$example/overlays"
        if [ -d "$overlays_dir" ]; then
            local overlay
            for overlay_path in "$overlays_dir"/*; do
                if [ -d "$overlay_path" ]; then
                    overlay="$(basename "$overlay_path")"
                    test_kustomize_syntax "$example" "$overlay" || true
                fi
            done
        else
            log_warn "$example: overlays directory missing, skipping overlay checks"
        fi
    done
    
    # Ask if user wants to run full integration test
    echo ""
    read -p "Run full ArgoCD integration test? This will create a k3d cluster (y/N): " -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        test_argocd_full || true
    else
        log_warn "Skipping ArgoCD integration test"
    fi
    
    # Display summary
    display_summary
}

# Usage
if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
    cat <<EOF
Test All Examples

USAGE:
    $0 [OPTIONS]

DESCRIPTION:
    Tests all example Kustomize configurations for syntax validity.
    Optionally runs full integration test for ArgoCD.

REQUIREMENTS:
    - kustomize (required)
    - k3d-local (optional, for integration test)
    - kubectl (optional, for integration test)

EOF
    exit 0
fi

main
