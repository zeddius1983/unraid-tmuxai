# Installation Examples

## Example 1: Install from GitHub (Manual)

```bash
# SSH into your Unraid server
ssh root@tower

# Download the plugin
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/master/tmuxai.plg -O /boot/config/plugins/tmuxai.plg

# Install the plugin
installplg /boot/config/plugins/tmuxai.plg

# Verify installation
tmuxai --version || echo "tmuxai is ready to configure"
```

## Example 2: Configure with OpenAI

```bash
# Run the setup helper
bash /boot/config/plugins/tmuxai/setup.sh

# Or manually configure
echo 'export OPENAI_API_KEY="sk-your-api-key-here"' >> /boot/config/go
source /boot/config/go

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
# Set API key
export ANTHROPIC_API_KEY="sk-ant-your-api-key-here"

# Add to go file for persistence
echo 'export ANTHROPIC_API_KEY="sk-ant-your-api-key-here"' >> /boot/config/go

# Test
tmuxai ask "Explain Docker networks"
```

## Example 5: Use with Custom API

```bash
# For OpenAI-compatible APIs (like LocalAI, Ollama with OpenAI API)
export OPENAI_API_KEY="your-api-key"
export OPENAI_API_BASE="http://localhost:8080/v1"

# Add to go file
cat >> /boot/config/go << 'EOF'
export OPENAI_API_KEY="your-api-key"
export OPENAI_API_BASE="http://localhost:8080/v1"
EOF

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
installplg /boot/config/plugins/tmuxai.plg --update

# Or remove and reinstall:
removepkg tmuxai
installplg /boot/config/plugins/tmuxai.plg
```

## Example 9: Troubleshooting

```bash
# Check if installed
which tmuxai
ls -l /usr/local/bin/tmuxai

# Check API key
echo $OPENAI_API_KEY

# Check configuration
cat /boot/config/plugins/tmuxai/config/README.txt

# View plugin files
ls -la /boot/config/plugins/tmuxai/

# Check if running in tmux
echo $TMUX
```

## Example 10: Integration with .bashrc

```bash
# Add to ~/.bashrc for easy access
cat >> ~/.bashrc << 'EOF'

# TmuxAI configuration
if [ -f /boot/config/plugins/tmuxai/config/.tmuxairc ]; then
    source /boot/config/plugins/tmuxai/config/.tmuxairc
fi

# Alias for quick AI questions
alias ai='tmuxai ask'
EOF

# Reload
source ~/.bashrc

# Now you can use:
ai "How do I restart Docker?"
```
