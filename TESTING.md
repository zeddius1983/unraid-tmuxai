# Testing TmuxAI Plugin on Your Unraid Server

This guide provides step-by-step instructions for testing the TmuxAI plugin on your Unraid server before or after official release.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Method 1: Test from GitHub (Development Version)](#method-1-test-from-github-development-version)
- [Method 2: Test Local Changes](#method-2-test-local-changes)
- [Configuration and Testing](#configuration-and-testing)
- [Verification Steps](#verification-steps)
- [Troubleshooting](#troubleshooting)
- [Cleanup and Removal](#cleanup-and-removal)

## Prerequisites

Before testing, ensure you have:

- ✅ **Unraid server** running version 6.9.0 or later
- ✅ **SSH access** to your Unraid server
- ✅ **Root access** (you'll be logged in as root via SSH)
- ✅ **Internet connection** on your Unraid server
- ✅ **AI API key** from one of these providers:
  - OpenAI (https://platform.openai.com/api-keys)
  - Anthropic (https://console.anthropic.com/)
  - Google AI (https://aistudio.google.com/app/apikey)

## Method 1: Test from GitHub (Development Version)

This method tests the plugin directly from the GitHub repository.

### Step 1: Connect to Your Unraid Server

```bash
# From your local computer, SSH into your Unraid server
ssh root@YOUR_UNRAID_IP

# Example:
ssh root@192.168.1.100
```

**Note:** Replace `YOUR_UNRAID_IP` with your actual Unraid server IP address.

### Step 2: Download the Plugin

```bash
# Download the plugin file from GitHub
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg \
  -O /boot/config/plugins/tmuxai.plg

# Or if testing a specific branch (e.g., development branch):
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/YOUR_BRANCH/tmuxai.plg \
  -O /boot/config/plugins/tmuxai.plg
```

### Step 3: Install the Plugin

```bash
# Install the plugin
# For Unraid 6.x:
installplg /boot/config/plugins/tmuxai.plg

# For Unraid 7:
plugin install /boot/config/plugins/tmuxai.plg

# Watch the installation output for any errors
```

**Expected output:**
```
Installing tmuxai plugin...
Downloading tmuxai...
tmuxai installed successfully!
See /boot/config/plugins/tmuxai/config/README.txt for configuration instructions.
TmuxAI plugin installation complete!
```

### Step 4: Verify Installation

```bash
# Check if tmuxai is installed
which tmuxai

# Expected output: /usr/local/bin/tmuxai

# Try to run tmuxai (will fail without API key, but confirms it's installed)
tmuxai --version
# or
tmuxai --help
```

## Method 2: Test Local Changes

If you're developing the plugin and want to test local changes:

### Step 1: Prepare Your Modified Files

On your development machine:

```bash
# Clone the repository
git clone https://github.com/zeddius1983/unraid-tmuxai.git
cd unraid-tmuxai

# Make your changes to tmuxai.plg or other files
# ...

# Commit your changes
git add .
git commit -m "Your changes"
git push origin YOUR_BRANCH
```

### Step 2: Test from Your Branch

On your Unraid server:

```bash
# Download from your branch
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/YOUR_BRANCH/tmuxai.plg \
  -O /boot/config/plugins/tmuxai.plg

# Install (For Unraid 6.x)
installplg /boot/config/plugins/tmuxai.plg

# Install (For Unraid 7)
plugin install /boot/config/plugins/tmuxai.plg
```

### Step 3: Alternative - Use Local HTTP Server

If you want to test without pushing to GitHub:

**On your development machine:**
```bash
# Start a simple HTTP server in the repository directory
cd unraid-tmuxai
python3 -m http.server 8000
```

**On your Unraid server:**
```bash
# Download from your local server
wget http://YOUR_DEV_MACHINE_IP:8000/tmuxai.plg \
  -O /boot/config/plugins/tmuxai.plg

# Install (For Unraid 6.x)
installplg /boot/config/plugins/tmuxai.plg

# Install (For Unraid 7)
plugin install /boot/config/plugins/tmuxai.plg
```

## Configuration and Testing

### Option A: Use the Setup Wizard (Recommended)

```bash
# Run the interactive setup script
bash /boot/config/plugins/tmuxai/setup.sh
```

Follow the prompts to:
1. Select your AI provider (OpenAI, Anthropic, Google, or Custom)
2. Enter your API key
3. Choose whether to persist configuration

### Option B: Manual Configuration

```bash
# Set your API key for the current session
export OPENAI_API_KEY="sk-your-actual-api-key-here"

# Or for Anthropic:
export ANTHROPIC_API_KEY="sk-ant-your-actual-api-key-here"

# Or for Google:
export GOOGLE_API_KEY="your-google-api-key-here"
```

### Option C: Persistent Configuration

To make the API key persist across reboots:

```bash
# Edit the Unraid go file
nano /boot/config/go

# Add this line at the end (replace with your actual key):
export OPENAI_API_KEY="sk-your-actual-api-key-here"

# Save (Ctrl+O, Enter) and exit (Ctrl+X)

# Load the configuration now
source /boot/config/go
```

## Verification Steps

### 1. Test Basic Functionality

```bash
# Test tmuxai with a simple question
tmuxai ask "What is the capital of France?"

# Expected: You should get an AI response
```

### 2. Test in Tmux

```bash
# Start a new tmux session
tmux new -s test

# Inside tmux, press: Ctrl+b then Shift+C
# This should open an AI prompt

# Or use the CLI while in tmux:
tmuxai ask "How do I list Docker containers?"

# Exit tmux
exit
```

### 3. Test Different Providers

If you have multiple API keys:

```bash
# Test OpenAI
export OPENAI_API_KEY="sk-your-openai-key"
tmuxai ask "Test OpenAI"

# Test Anthropic
export ANTHROPIC_API_KEY="sk-ant-your-anthropic-key"
tmuxai ask "Test Anthropic"
```

### 4. Verify Configuration Persistence

```bash
# Check that config files were created
ls -la /boot/config/plugins/tmuxai/
ls -la /boot/config/plugins/tmuxai/config/

# Verify the symlink was created
ls -la /root/.config/tmuxai
# Should show: tmuxai -> /boot/config/plugins/tmuxai/config

# Check persisted config directory
ls -la /boot/config/plugins/tmuxai/config/

# View the README
cat /boot/config/plugins/tmuxai/config/README.txt
```

### 5. Test After Reboot

```bash
# Reboot your Unraid server
reboot

# After reboot, SSH back in and test
ssh root@YOUR_UNRAID_IP

# Verify symlink still exists (it should be recreated on boot)
ls -la /root/.config/tmuxai
# Should show: tmuxai -> /boot/config/plugins/tmuxai/config

# Test that your config persisted
tmuxai ask "Test after reboot"

# If you created any config files, verify they still exist
ls -la /root/.config/tmuxai/
# or
ls -la /boot/config/plugins/tmuxai/config/
```

## Troubleshooting

### Issue 1: tmuxai Command Not Found

**Symptoms:**
```bash
-bash: tmuxai: command not found
```

**Solutions:**
```bash
# Check if it's installed
ls -l /usr/local/bin/tmuxai

# If not there, check if pip installation was used
which tmuxai

# Try reinstalling
removepkg tmuxai
installplg /boot/config/plugins/tmuxai.plg  # Unraid 6.x
# OR
plugin install /boot/config/plugins/tmuxai.plg  # Unraid 7

# Check installation logs
cat /var/log/syslog | grep tmuxai
```

### Issue 2: API Key Not Working

**Symptoms:**
```
Error: API key not set
```

**Solutions:**
```bash
# Verify the API key is set
echo $OPENAI_API_KEY

# If empty, set it:
export OPENAI_API_KEY="sk-your-key"

# Check if the key is valid (test with curl)
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer $OPENAI_API_KEY"
```

### Issue 3: Installation Fails

**Symptoms:**
```
ERROR: Could not install tmuxai
```

**Solutions:**
```bash
# Check internet connectivity
ping -c 3 github.com

# Check architecture
uname -m

# Try manual pip installation
pip3 install tmuxai
# or
pip install tmuxai

# Check detailed logs
tail -50 /var/log/syslog
```

### Issue 4: Plugin Shows as Installed but Doesn't Work

**Solutions:**
```bash
# Remove the plugin completely
removepkg tmuxai
rm -rf /boot/config/plugins/tmuxai

# Clean install
installplg /boot/config/plugins/tmuxai.plg  # Unraid 6.x
# OR
plugin install /boot/config/plugins/tmuxai.plg  # Unraid 7

# Run setup again
bash /boot/config/plugins/tmuxai/setup.sh
```

### Issue 5: Different Architecture

**Symptoms:**
```
Unsupported architecture: armv7l
```

**Solutions:**
```bash
# Check your architecture
uname -m

# If not x86_64 or aarch64, use pip installation
pip3 install tmuxai
```

### Issue 6: Permission Denied

**Symptoms:**
```
Permission denied: /usr/local/bin/tmuxai
```

**Solutions:**
```bash
# Fix permissions
chmod +x /usr/local/bin/tmuxai

# Verify ownership
ls -l /usr/local/bin/tmuxai
```

## Testing Checklist

Use this checklist to ensure comprehensive testing:

- [ ] Plugin downloads and installs without errors
- [ ] `tmuxai` command is available in PATH
- [ ] `tmuxai --help` shows help information
- [ ] Setup wizard runs successfully
- [ ] API key configuration works
- [ ] Simple question gets AI response
- [ ] Works inside tmux session
- [ ] Tmux keybinding (Ctrl+b, Shift+C) works
- [ ] Configuration persists after reboot
- [ ] Plugin shows in Unraid WebGUI (if applicable)
- [ ] Removal works cleanly
- [ ] Reinstallation works
- [ ] Different AI providers work (if you have keys)

## Advanced Testing

### Test Multiple AI Providers

```bash
# Create a test script
cat > /tmp/test_providers.sh << 'EOF'
#!/bin/bash

echo "Testing OpenAI..."
export OPENAI_API_KEY="sk-your-openai-key"
tmuxai ask "Say 'OpenAI works'"

echo -e "\nTesting Anthropic..."
export ANTHROPIC_API_KEY="sk-ant-your-anthropic-key"
tmuxai ask "Say 'Anthropic works'"

echo -e "\nTesting Google..."
export GOOGLE_API_KEY="your-google-key"
tmuxai ask "Say 'Google works'"
EOF

chmod +x /tmp/test_providers.sh
/tmp/test_providers.sh
```

### Test Error Handling

```bash
# Test with invalid API key
export OPENAI_API_KEY="invalid-key"
tmuxai ask "This should fail gracefully"

# Test without internet (if possible)
# Disconnect network and test
```

### Performance Testing

```bash
# Test response time
time tmuxai ask "Quick question"

# Test with longer questions
tmuxai ask "Write a detailed explanation of Docker networking in Unraid"
```

## Cleanup and Removal

### Remove the Plugin

```bash
# Uninstall the plugin
removepkg tmuxai

# Verify removal
which tmuxai  # Should return nothing

# Check that config is preserved
ls /boot/config/plugins/tmuxai/config/
```

### Complete Cleanup (Remove Everything)

```bash
# Remove the plugin
removepkg tmuxai

# Remove all configuration
rm -rf /boot/config/plugins/tmuxai

# Remove from go file if you added it
nano /boot/config/go
# Delete the line with OPENAI_API_KEY (or other API key)

# Verify complete removal
which tmuxai  # Should return nothing
ls /boot/config/plugins/tmuxai  # Should not exist
```

## Reporting Issues

If you encounter issues during testing:

1. **Gather Information:**
   ```bash
   # System info
   uname -a
   
   # Unraid version
   cat /etc/unraid-version
   
   # Plugin status
   ls -la /usr/local/bin/tmuxai
   ls -la /boot/config/plugins/tmuxai/
   
   # Recent logs
   tail -100 /var/log/syslog | grep -i tmuxai
   ```

2. **Create an Issue:**
   - Go to: https://github.com/zeddius1983/unraid-tmuxai/issues
   - Click "New Issue"
   - Include:
     - Unraid version
     - Architecture (x86_64 or ARM64)
     - Steps to reproduce
     - Error messages
     - Logs

3. **Forum Support:**
   - Post in Unraid forums Plugin Support section
   - Link to the GitHub repository

## Testing Best Practices

1. **Test on a Non-Production System First**
   - Use a test VM or spare Unraid server
   - Don't test on your main production array initially

2. **Backup Your Configuration**
   ```bash
   # Backup before testing
   cp /boot/config/go /boot/config/go.backup
   ```

3. **Use Test API Keys**
   - Use API keys with spending limits
   - Don't use production API keys for testing

4. **Document Your Tests**
   - Keep notes of what works and what doesn't
   - Record error messages
   - Note your specific configuration

5. **Test All Features**
   - Don't just test the happy path
   - Try to break things intentionally
   - Test edge cases

## Next Steps After Testing

Once testing is successful:

1. ✅ Mark testing as complete
2. ✅ Report any bugs found
3. ✅ Suggest improvements
4. ✅ Consider submitting to Community Applications
5. ✅ Create a forum support thread
6. ✅ Share your experience with the community

## Quick Reference

```bash
# Install
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg -O /boot/config/plugins/tmuxai.plg

# For Unraid 6.x:
installplg /boot/config/plugins/tmuxai.plg
# For Unraid 7:
plugin install /boot/config/plugins/tmuxai.plg

# Configure
bash /boot/config/plugins/tmuxai/setup.sh

# Test
tmuxai ask "Test question"

# Remove
removepkg tmuxai

# Logs
tail -f /var/log/syslog | grep tmuxai
```

## Support

- **GitHub Issues:** https://github.com/zeddius1983/unraid-tmuxai/issues
- **Documentation:** See README.md, QUICKSTART.md, EXAMPLES.md
- **Community:** Unraid Forums Plugin Support

---

**Happy Testing! 🚀**
