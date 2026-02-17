# TmuxAI Quick Reference

## Installation

```bash
# Install via Unraid Community Applications
# Or manually:
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg

# For Unraid 6.x:
installplg tmuxai.plg
# For Unraid 7:
plugin install tmuxai.plg
```

## Setup

Configure your API key:

**Option 1: Via Unraid WebGUI**
1. Go to Settings > User Utilities > TmuxAI
2. Edit the config.yaml in the configuration editor
3. Save your changes

**Option 2: Edit config file directly**
```bash
nano /mnt/user/appdata/tmuxai/config/config.yaml
```

Add your model configuration:
```yaml
models:
  gpt-4:
    provider: "openai"
    model: "gpt-4"
    api_key: "sk-..."
```

## Common Commands

```bash
# Ask AI a question
tmuxai ask "How do I list Docker containers?"

# Get help
tmuxai --help

# Check version
tmuxai --version
```

## Tmux Integration

Inside a tmux session:
- Press `Ctrl+b` (prefix) then `C` (capital C) to ask AI

## Configuration Files

- Plugin metadata: `/boot/config/plugins/tmuxai/` (plugin files only)
- Config directory: `/mnt/user/appdata/tmuxai/config/` (persisted on array)
- Config file: `/mnt/user/appdata/tmuxai/config/config.yaml`
- tmuxai config: `/root/.config/tmuxai/` (symlink to `/mnt/user/appdata/tmuxai/config`)
- Binary location: `/usr/local/bin/tmuxai`

**Note:** The plugin creates a symlink from `/root/.config/tmuxai` to `/mnt/user/appdata/tmuxai/config` to ensure your tmuxai configuration persists across Unraid reboots and uses faster array storage instead of USB flash.

## Environment Variables

You can also configure tmuxai using environment variables (optional):

```bash
# Add to /boot/config/go for persistence across reboots

# OpenAI
export OPENAI_API_KEY="sk-..."

# Anthropic (Claude)
export ANTHROPIC_API_KEY="sk-ant-..."

# Google (Gemini)  
export GOOGLE_API_KEY="..."
```

**Note:** Using config.yaml (via Settings > User Utilities > TmuxAI) is the recommended method.

## Examples

```bash
# Linux system administration
tmuxai ask "Show me how to check disk space usage"

# Docker management
tmuxai ask "How do I stop all running containers?"

# Unraid specific
tmuxai ask "How do I add a new share in Unraid?"

# Debugging
tmuxai ask "Why is my array not mounting?"
```

## Troubleshooting

```bash
# Check if tmuxai is installed
which tmuxai

# Check configuration file
cat /mnt/user/appdata/tmuxai/config/config.yaml

# View config directory
ls -la /mnt/user/appdata/tmuxai/config/

# Check if running in tmux
echo $TMUX
```

## Uninstall

```bash
# Remove plugin
removepkg tmuxai

# Configuration files remain in:
# /mnt/user/appdata/tmuxai/
```
