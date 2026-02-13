# unraid-tmuxai

TmuxAI plugin for Unraid - Integrate AI capabilities into your tmux sessions

## About

This plugin installs [tmuxai](https://github.com/alvinunreal/tmuxai), a powerful CLI tool that brings AI assistance directly into your tmux terminal sessions on Unraid. With tmuxai, you can interact with AI models (ChatGPT, Claude, Gemini, etc.) without leaving your terminal.

## Features

- 🤖 AI integration in tmux sessions
- 🔧 Support for multiple AI providers (OpenAI, Anthropic, Google, etc.)
- 🚀 Easy installation via Unraid Community Applications
- 💾 Persistent configuration across reboots
- 🏗️ Support for both x86_64 and ARM64 architectures

## Quick Start for Testing

**Want to test this plugin on your Unraid server?**

```bash
# SSH to your Unraid server
ssh root@YOUR_UNRAID_IP

# Download and install
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg \
  -O /boot/config/plugins/tmuxai.plg

# For Unraid 6.x:
installplg /boot/config/plugins/tmuxai.plg
# For Unraid 7:
plugin install /boot/config/plugins/tmuxai.plg

# Configure your API key
# Option 1: Via User Utilities in Unraid WebGUI (Settings > User Utilities > TmuxAI)
# Option 2: Edit config file directly
nano /boot/config/plugins/tmuxai/config/config.yaml

# Test it!
tmuxai ask "What is Unraid?"
```

📖 **Full testing guide:** See [TESTING.md](TESTING.md) for detailed instructions, troubleshooting, and best practices.

## Installation

### Method 1: Community Applications (Recommended)

1. Open Unraid WebGUI
2. Go to **Apps** tab
3. Search for **tmuxai**
4. Click **Install**

### Method 2: Manual Installation

1. Download the plugin file:
   ```bash
   wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg -O /boot/config/plugins/tmuxai.plg
   ```

2. Install the plugin:
   ```bash
   # For Unraid 6.x:
   installplg /boot/config/plugins/tmuxai.plg
   
   # For Unraid 7:
   plugin install /boot/config/plugins/tmuxai.plg
   ```

## Configuration

After installation, you need to configure your AI provider credentials:

### Option 1: Via Unraid WebGUI (Recommended)

1. Open Unraid WebGUI
2. Go to **Settings** > **User Utilities** > **TmuxAI**
3. Edit the `config.yaml` file in the configuration editor
4. Add your AI provider configuration (see examples in the config file)
5. Click **Save Configuration**

### Option 2: Edit Configuration File Directly

1. **Edit the config file:**
   ```bash
   nano /boot/config/plugins/tmuxai/config/config.yaml
   ```

2. **Add your AI provider configuration:**
   ```yaml
   models:
     gpt-4:
       provider: "openai"
       model: "gpt-4"
       api_key: "YOUR_API_KEY_HERE"
   ```

3. **Verify installation:**
   ```bash
   tmuxai --version
   ```

## Usage

### Basic Usage

1. **Start a tmux session:**
   ```bash
   tmux
   ```

2. **Ask AI a question** (from within tmux):
   - Press your tmux prefix key (default: `Ctrl+b`) followed by `C` (capital C)
   - Or use the CLI directly:
     ```bash
     tmuxai ask "How do I list all Docker containers?"
     ```

### Common Use Cases

```bash
# Get command explanations
tmuxai ask "Explain this command: docker ps -a"

# Generate commands
tmuxai ask "Show me how to find large files in /mnt/user"

# Debug issues
tmuxai ask "Why is my Docker container not starting?"

# Learn Unraid specifics
tmuxai ask "How do I add a new cache pool in Unraid?"
```

### Advanced Configuration

tmuxai configuration is automatically persisted across Unraid reboots:
- Config file location: `/boot/config/plugins/tmuxai/config/config.yaml`
- Symlink created at: `/root/.config/tmuxai` → `/boot/config/plugins/tmuxai/config`

Edit the config file to customize tmuxai behavior:

```yaml
# Example configuration
models:
  gpt-4:
    provider: "openai"
    model: "gpt-4"
    api_key: "sk-..."
    temperature: 0.7
  
  claude:
    provider: "anthropic"
    model: "claude-3-opus-20240229"
    api_key: "sk-ant-..."
```

**Note:** The plugin automatically creates a symlink to ensure your tmuxai configuration persists across reboots, as `/root/.config` is not persisted by default in Unraid.

## Supported AI Providers

- **OpenAI** (GPT-3.5, GPT-4, etc.)
- **Anthropic** (Claude)
- **Google** (Gemini)
- **OpenAI-compatible APIs** (LocalAI, Ollama, etc.)

## Troubleshooting

### tmuxai command not found

Make sure the plugin is installed correctly:
```bash
ls -l /usr/local/bin/tmuxai
```

If missing, reinstall the plugin.

### API key not working

Verify your API key is set:
```bash
echo $OPENAI_API_KEY
```

### Getting help

Check the configuration readme:
```bash
cat /boot/config/plugins/tmuxai/config/README.txt
```

## Uninstallation

1. **Via WebGUI:**
   - Go to **Plugins** tab
   - Find **tmuxai**
   - Click **Remove**

2. **Via CLI:**
   ```bash
   removepkg tmuxai
   ```

Note: Configuration files are preserved in `/boot/config/plugins/tmuxai` even after uninstallation.

## Requirements

- Unraid 6.9.0 or later
- Internet connection for API access
- API key from supported AI provider

## Testing

Want to test the plugin on your Unraid server? See the comprehensive [Testing Guide](TESTING.md) for:
- Step-by-step installation instructions
- Configuration testing
- Troubleshooting common issues
- Testing checklist

## Support

- GitHub Issues: [https://github.com/zeddius1983/unraid-tmuxai/issues](https://github.com/zeddius1983/unraid-tmuxai/issues)
- Unraid Forums: [https://forums.unraid.net/](https://forums.unraid.net/)

## Credits

- tmuxai project: [https://github.com/alvinunreal/tmuxai](https://github.com/alvinunreal/tmuxai)
- Plugin maintained by: zeddius1983

## License

This plugin follows the license of the tmuxai project. See the tmuxai repository for details.
