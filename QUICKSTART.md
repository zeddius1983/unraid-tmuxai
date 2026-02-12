# TmuxAI Quick Reference

## Installation

```bash
# Install via Unraid Community Applications
# Or manually:
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg
installplg tmuxai.plg
```

## Setup

Run the setup helper:
```bash
bash /boot/config/plugins/tmuxai/setup.sh
```

Or manually set your API key:
```bash
export OPENAI_API_KEY="sk-..."
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

- Plugin config: `/boot/config/plugins/tmuxai/`
- User config: `/boot/config/plugins/tmuxai/config/.tmuxairc`
- Binary location: `/usr/local/bin/tmuxai`

## Environment Variables

```bash
# OpenAI
export OPENAI_API_KEY="sk-..."

# Anthropic (Claude)
export ANTHROPIC_API_KEY="sk-ant-..."

# Google (Gemini)
export GOOGLE_API_KEY="..."
```

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

# Verify API key is set
echo $OPENAI_API_KEY

# Check logs
ls /var/log/tmuxai/

# Re-run setup
bash /boot/config/plugins/tmuxai/setup.sh
```

## Uninstall

```bash
# Remove plugin
removepkg tmuxai

# Configuration files remain in:
# /boot/config/plugins/tmuxai/
```
