#!/usr/bin/env bash
# Claude Code Launcher for Unix (Git Bash, Linux, macOS)
# Usage: ./claude-code.sh [options]
#
# Configuration:
#   Set ANTHROPIC_API_KEY env var, or create a .env file in the same directory.
#   Format: ANTHROPIC_API_KEY=sk-ant-...

# === Bun Path ===
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"

# === Load API Keys from .env file (if not already set in environment) ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -z "$ANTHROPIC_API_KEY" ] && [ -f "$SCRIPT_DIR/.env" ]; then
    while IFS='=' read -r key value; do
        # Skip comments and empty lines
        case "$key" in \#*|""|*[[:space:]]*) continue ;; esac
        if [ "$key" = "ANTHROPIC_API_KEY" ]; then
            export ANTHROPIC_API_KEY="$value"
        fi
    done < "$SCRIPT_DIR/.env"
fi

# === Claude Code Directory ===
CLAUDE_CODE_DIR="${SCRIPT_DIR}/claude-code"

# === Check Bun ===
if ! command -v bun &> /dev/null; then
    echo "ERROR: Bun not found. Please ensure Bun is installed at $BUN_INSTALL"
    exit 1
fi

# === Check Directory ===
if [ ! -f "$CLAUDE_CODE_DIR/src/entrypoints/cli.tsx" ]; then
    echo "ERROR: Claude Code source not found at $CLAUDE_CODE_DIR"
    exit 1
fi

# === Check API Key ===
if [ -z "$ANTHROPIC_API_KEY" ]; then
    echo "WARNING: ANTHROPIC_API_KEY is not set."
    echo "Claude Code requires an Anthropic API key to run."
    echo ""
    echo "To set it up:"
    echo "  1. Create a .env file in this directory with:"
    echo "     ANTHROPIC_API_KEY=sk-ant-..."
    echo "  2. Or add to your ~/.bashrc:"
    echo "     export ANTHROPIC_API_KEY='sk-ant-...'"
    echo "  3. Or export it before running:"
    echo "     ANTHROPIC_API_KEY=sk-ant-... ./claude-code.sh"
    echo ""
    echo "Get your key at: https://console.anthropic.com/settings/keys"
    echo ""
    exit 1
fi

# === Run Claude Code ===
cd "$CLAUDE_CODE_DIR"

# Pass all arguments through
bun run start -- "$@"
