**TmuxAI - AI-Powered Terminal Assistant**

TmuxAI brings powerful AI assistance directly into your tmux terminal sessions on Unraid.

**Features:**
- Integrate with ChatGPT, Claude, Gemini, and other AI models
- Get command help and suggestions without leaving your terminal
- Support for multiple AI providers
- Easy configuration through the Settings tab
- Configuration persists across Unraid reboots

**Quick Setup:**
1. Install the plugin
2. Go to Settings > TmuxAI to configure your API keys
3. Start tmux and use AI assistance with `prefix + C`

**Supported AI Providers:**
- OpenAI (GPT-3.5, GPT-4)
- Anthropic (Claude)
- Google (Gemini)
- OpenRouter
- Other OpenAI-compatible APIs

**Configuration:**
Your configuration is stored in `/boot/config/plugins/tmuxai/config/config.yaml` and persists across reboots.

**Usage:**
- Inside tmux: Press `Ctrl+b` then `C` (capital C) to ask AI
- Command line: `tmuxai ask "your question"`

**Documentation:**
For more details, visit https://tmuxai.dev
