#!/bin/bash
#
# TmuxAI Plugin Test Script
# This script helps test the plugin installation and functionality
#

set -e

echo "========================================"
echo "TmuxAI Plugin Test Script"
echo "========================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Helper functions
pass() {
    echo -e "${GREEN}✓${NC} $1"
    TESTS_PASSED=$((TESTS_PASSED + 1))
}

fail() {
    echo -e "${RED}✗${NC} $1"
    TESTS_FAILED=$((TESTS_FAILED + 1))
}

warn() {
    echo -e "${YELLOW}!${NC} $1"
}

# Test 1: Check if plugin file exists
echo "Test 1: Plugin file exists"
if [ -f "tmuxai.plg" ]; then
    pass "Plugin file exists"
else
    fail "Plugin file not found"
fi
echo ""

# Test 2: Validate XML structure
echo "Test 2: XML structure validation"
if python3 -c "import xml.etree.ElementTree as ET; ET.parse('tmuxai.plg')" 2>/dev/null; then
    pass "Plugin XML is well-formed"
else
    fail "Plugin XML has errors"
fi
echo ""

# Test 3: Check required plugin elements
echo "Test 3: Required plugin elements"
if grep -q 'name="tmuxai"' tmuxai.plg; then
    pass "Plugin name defined"
else
    fail "Plugin name missing"
fi

if grep -q 'version=' tmuxai.plg; then
    pass "Plugin version defined"
else
    fail "Plugin version missing"
fi

if grep -q "<CHANGES>" tmuxai.plg; then
    pass "Changelog section present"
else
    fail "Changelog section missing"
fi
echo ""

# Test 4: Check icon file
echo "Test 4: Icon file validation"
if [ -f "tmuxai.png" ]; then
    pass "Icon file exists"
    if file tmuxai.png | grep -q "PNG image"; then
        pass "Icon is valid PNG format"
    else
        fail "Icon is not a valid PNG"
    fi
else
    fail "Icon file not found"
fi
echo ""

# Test 5: Check documentation files
echo "Test 5: Documentation files"
for doc in README.md CHANGELOG.md LICENSE CONTRIBUTING.md QUICKSTART.md; do
    if [ -f "$doc" ]; then
        pass "$doc exists"
    else
        fail "$doc missing"
    fi
done
echo ""

# Test 6: Check Settings page
echo "Test 6: Settings page"
if [ -f "source/usr/local/emhttp/plugins/tmuxai/TmuxAI.page" ]; then
    pass "Settings page exists"
else
    fail "Settings page missing"
fi

if [ -f "source/usr/local/emhttp/plugins/tmuxai/README.md" ]; then
    pass "Plugin README exists"
else
    fail "Plugin README missing"
fi

if [ -f "source/usr/local/emhttp/plugins/tmuxai/tmuxai.png" ]; then
    pass "Plugin icon exists in emhttp directory"
else
    fail "Plugin icon missing in emhttp directory"
fi
echo ""

# Test 7: Validate plugin structure
echo "Test 7: Plugin structure validation"
if grep -q "TmuxAI.page" tmuxai.plg; then
    pass "Settings page referenced in plugin"
else
    fail "Settings page not referenced in plugin"
fi
echo ""

# Test 8: Check for common issues
echo "Test 8: Common issues check"

# Check for hardcoded paths that might not work
if grep -q "/mnt/user" tmuxai.plg 2>/dev/null; then
    warn "Found hardcoded /mnt/user path - may not work on all systems"
else
    pass "No hardcoded user paths found"
fi

# Check config file is referenced
if grep -q "config.yaml" tmuxai.plg; then
    pass "Config file referenced in plugin"
else
    warn "Config file not referenced in plugin"
fi

# Check for proper cleanup
if grep -q "rm -f" tmuxai.plg; then
    pass "Removal script includes cleanup"
else
    warn "Removal script may not include proper cleanup"
fi
echo ""

# Test 9: GitHub URLs
echo "Test 9: GitHub URLs validation"
if grep -q "github.com/zeddius1983/unraid-tmuxai" tmuxai.plg README.md; then
    pass "GitHub repository URLs found"
else
    warn "GitHub repository URLs may be missing"
fi
echo ""

# Summary
echo "========================================"
echo "Test Summary"
echo "========================================"
echo -e "${GREEN}Tests passed: $TESTS_PASSED${NC}"
echo -e "${RED}Tests failed: $TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed! ✓${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Test the plugin on an actual Unraid system"
    echo "2. Submit to Community Applications"
    echo "3. Create a support thread on Unraid forums"
    exit 0
else
    echo -e "${RED}Some tests failed. Please fix the issues before submitting.${NC}"
    exit 1
fi
