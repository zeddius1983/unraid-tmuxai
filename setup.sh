#!/bin/bash
#
# TmuxAI Setup Helper Script
# This script helps you configure tmuxai on your Unraid system
#

set -e

echo "========================================"
echo "TmuxAI Setup Helper"
echo "========================================"
echo ""

# Check if tmuxai is installed
if ! command -v tmuxai &> /dev/null; then
    echo "ERROR: tmuxai is not installed. Please install the plugin first."
    exit 1
fi

echo "✓ tmuxai is installed"
echo ""

# Ask for AI provider
echo "Which AI provider would you like to use?"
echo "1) OpenAI (ChatGPT)"
echo "2) Anthropic (Claude)"
echo "3) Google (Gemini)"
echo "4) OpenRouter"
echo "5) Other (OpenAI-compatible)"
read -p "Enter your choice (1-5): " provider_choice

case $provider_choice in
    1)
        PROVIDER="openai"
        ENV_VAR="OPENAI_API_KEY"
        MODEL_DEFAULT="gpt-3.5-turbo"
        ;;
    2)
        PROVIDER="anthropic"
        ENV_VAR="ANTHROPIC_API_KEY"
        MODEL_DEFAULT="claude-3-sonnet-20240229"
        ;;
    3)
        PROVIDER="google"
        ENV_VAR="GOOGLE_API_KEY"
        MODEL_DEFAULT="gemini-pro"
        ;;
    4)
        PROVIDER="openrouter"
        ENV_VAR="OPENROUTER_API_KEY"
        MODEL_DEFAULT="openai/gpt-3.5-turbo"
        ;;
    5)
        PROVIDER="custom"
        read -p "Enter your API base URL: " API_BASE
        ENV_VAR="OPENAI_API_KEY"
        MODEL_DEFAULT="gpt-3.5-turbo"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Ask for API key
echo ""
read -sp "Enter your ${PROVIDER} API key: " API_KEY
echo ""

if [ -z "$API_KEY" ]; then
    echo "ERROR: API key cannot be empty."
    exit 1
fi

# Ask if user wants to persist the configuration
echo ""
read -p "Do you want to persist this configuration across reboots? (y/n): " persist

if [[ $persist =~ ^[Yy]$ ]]; then
    # Add to /boot/config/go
    GO_FILE="/boot/config/go"
    
    if [ ! -f "$GO_FILE" ]; then
        echo "#!/bin/bash" > "$GO_FILE"
        chmod +x "$GO_FILE"
    fi
    
    # Check if the variable already exists
    if grep -q "export ${ENV_VAR}=" "$GO_FILE"; then
        echo "WARNING: ${ENV_VAR} already exists in $GO_FILE"
        read -p "Do you want to replace it? (y/n): " replace
        if [[ $replace =~ ^[Yy]$ ]]; then
            # Remove old line and add new one
            sed -i "/export ${ENV_VAR}=/d" "$GO_FILE"
            echo "export ${ENV_VAR}=\"${API_KEY}\"" >> "$GO_FILE"
            echo "✓ Configuration updated in $GO_FILE"
        fi
    else
        echo "" >> "$GO_FILE"
        echo "# TmuxAI configuration" >> "$GO_FILE"
        echo "export ${ENV_VAR}=\"${API_KEY}\"" >> "$GO_FILE"
        
        if [ "$PROVIDER" = "custom" ]; then
            echo "export OPENAI_API_BASE=\"${API_BASE}\"" >> "$GO_FILE"
        fi
        
        if [ "$PROVIDER" = "openrouter" ]; then
            echo "export OPENROUTER_API_BASE=\"https://openrouter.ai/api/v1\"" >> "$GO_FILE"
        fi
        
        echo "✓ Configuration added to $GO_FILE"
    fi
    
    # Set for current session as well
    export ${ENV_VAR}="${API_KEY}"
    if [ "$PROVIDER" = "custom" ]; then
        export OPENAI_API_BASE="${API_BASE}"
    fi
else
    # Only set for current session
    export ${ENV_VAR}="${API_KEY}"
    if [ "$PROVIDER" = "custom" ]; then
        export OPENAI_API_BASE="${API_BASE}"
    fi
    if [ "$PROVIDER" = "openrouter" ]; then
        export OPENROUTER_API_BASE="https://openrouter.ai/api/v1"
    fi
    echo "✓ Configuration set for current session only"
fi

# Create a config file
CONFIG_DIR="/boot/config/plugins/tmuxai/config"
mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_DIR/.tmuxairc" << EOF
# TmuxAI Configuration
# Generated on $(date)

export ${ENV_VAR}="${API_KEY}"
EOF

if [ "$PROVIDER" = "custom" ]; then
    echo "export OPENAI_API_BASE=\"${API_BASE}\"" >> "$CONFIG_DIR/.tmuxairc"
fi

if [ "$PROVIDER" = "openrouter" ]; then
    echo "export OPENROUTER_API_BASE=\"https://openrouter.ai/api/v1\"" >> "$CONFIG_DIR/.tmuxairc"
fi

chmod 600 "$CONFIG_DIR/.tmuxairc"

echo ""
echo "========================================"
echo "Setup Complete!"
echo "========================================"
echo ""
echo "You can now use tmuxai in your tmux sessions:"
echo "  1. Start tmux: tmux"
echo "  2. Press prefix + C to ask AI a question"
echo "  3. Or use: tmuxai ask 'your question'"
echo ""
echo "To load your configuration in a new session:"
echo "  source $CONFIG_DIR/.tmuxairc"
echo ""
