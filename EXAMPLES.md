# Installation Examples

## Example 1: Install from GitHub (Manual)

```bash
# SSH into your Unraid server
ssh root@tower

# Download the plugin
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg -O /boot/config/plugins/tmuxai.plg

# Install the plugin
# For Unraid 6.x:
installplg /boot/config/plugins/tmuxai.plg
# For Unraid 7:
plugin install /boot/config/plugins/tmuxai.plg

# Verify installation
tmuxai --version || echo "tmuxai is ready to configure"
```

## Example 2: Configure with OpenAI

```bash
# Edit configuration via WebGUI
# Go to Settings > TmuxAI in Unraid WebGUI
# Or edit directly:
nano /boot/config/plugins/tmuxai/config/config.yaml

# Add your configuration:
# models:
#   gpt-4:
#     provider: "openai"
#     model: "gpt-4"
#     api_key: "sk-your-api-key-here"

# Test it
tmuxai ask "How do I list Docker containers?"
```

## Example 3: Use in Tmux

```bash
# Start tmux
tmux

# Inside tmux, press: Ctrl+b then Shift+C
# Or use CLI:
tmuxai ask "How do I check disk space on Unraid?"
```

## Example 4: Configure with Claude (Anthropic)

```bash
# Edit config file
nano /boot/config/plugins/tmuxai/config/config.yaml

# Add your configuration:
# models:
#   claude:
#     provider: "anthropic"
#     model: "claude-3-opus-20240229"
#     api_key: "sk-ant-your-api-key-here"

# Test
tmuxai ask "Explain Docker networks"
```

## Example 5: Use with Custom API

```bash
# Edit config file
nano /boot/config/plugins/tmuxai/config/config.yaml

# For OpenAI-compatible APIs (like LocalAI, Ollama with OpenAI API)
# Add your configuration:
# models:
#   local-model:
#     provider: "openai"
#     model: "gpt-3.5-turbo"
#     api_key: "your-api-key"
#     base_url: "http://localhost:8080/v1"

# Test
tmuxai ask "Test question"
```

## Example 6: Common Commands

```bash
# System administration
tmuxai ask "How to find processes using high CPU?"

# Docker management  
tmuxai ask "Show me how to view Docker logs"

# Unraid specific
tmuxai ask "How to add a new cache drive in Unraid?"

# File operations
tmuxai ask "How to find files larger than 1GB?"

# Network troubleshooting
tmuxai ask "How to test network connectivity?"
```

## Example 7: Uninstall

```bash
# Remove the plugin
removepkg tmuxai

# Or via Web GUI: Plugins -> tmuxai -> Remove

# Config files remain in /boot/config/plugins/tmuxai/
# To completely remove:
rm -rf /boot/config/plugins/tmuxai/
```

## Example 8: Update Plugin

```bash
# Check for updates in Community Applications
# Or manually reinstall:
# For Unraid 6.x:
installplg /boot/config/plugins/tmuxai.plg --update
# For Unraid 7:
plugin install /boot/config/plugins/tmuxai.plg --update

# Or remove and reinstall:
removepkg tmuxai
# For Unraid 6.x:
installplg /boot/config/plugins/tmuxai.plg
# For Unraid 7:
plugin install /boot/config/plugins/tmuxai.plg
```

## Example 9: Troubleshooting

```bash
# Check if installed
which tmuxai
ls -l /usr/local/bin/tmuxai

# Check configuration
cat /boot/config/plugins/tmuxai/config/config.yaml

# View plugin files
ls -la /boot/config/plugins/tmuxai/

# Check if running in tmux
echo $TMUX
```

## Example 10: Quick Configuration Alias

```bash
# Add to ~/.bashrc for easy config access
cat >> ~/.bashrc << 'EOF'

# TmuxAI quick edit alias
alias tmuxai-config='nano /boot/config/plugins/tmuxai/config/config.yaml'

# Alias for quick AI questions
alias ai='tmuxai ask'
EOF

# Reload
source ~/.bashrc

# Now you can use:
tmuxai-config  # Edit configuration
ai "How do I restart Docker?"  # Quick AI question
```
