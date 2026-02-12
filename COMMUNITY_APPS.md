# Submitting to Unraid Community Applications

This guide explains how to submit the TmuxAI plugin to Unraid Community Applications.

## Prerequisites

1. ✅ Plugin is working and tested on Unraid
2. ✅ Repository is hosted on GitHub
3. ✅ Plugin follows Unraid plugin standards
4. ✅ All files are on the `main` branch

## Required Files

The following files must be present in the repository:

- [x] `tmuxai.plg` - Main plugin file
- [x] `tmuxai.png` - Plugin icon (PNG format)
- [x] `README.md` - Documentation
- [x] `tmuxai-template.xml` - Community Apps template (optional but recommended)

## Submission Process

### Step 1: Verify Plugin Structure

Make sure your plugin file (`tmuxai.plg`) includes:
- Valid XML structure
- Plugin metadata (name, version, author)
- Installation script
- Removal script
- Changelog

### Step 2: Test on Unraid

Before submitting, test the plugin on an Unraid system:

```bash
# Download and install
wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg
installplg tmuxai.plg

# Test functionality
tmuxai --version

# Test removal
removepkg tmuxai
```

### Step 3: Submit to Community Applications

1. **Fork the Community Applications Repository**
   ```bash
   https://github.com/Squidly271/AppFeed
   ```

2. **Add Your Plugin**
   
   Create a pull request to add your plugin to the appropriate category:
   
   - Navigate to the appropriate category folder (e.g., `Utilities/`)
   - Add a link to your plugin repository

3. **Plugin Information Format**
   
   Your plugin entry should include:
   ```
   Name: TmuxAI
   Repository: https://github.com/zeddius1983/unraid-tmuxai
   Plugin: https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg
   Icon: https://tmuxai.dev/_ipx/q_80&s_70x80/logo.svg
   Category: Utilities
   ```

### Step 4: Wait for Review

- Community Apps moderators will review your submission
- They may request changes or improvements
- Once approved, your plugin will appear in Community Applications

## Alternative: Create a Support Thread

1. **Post in Unraid Forums**
   
   Create a thread in the Plugin Support section:
   https://forums.unraid.net/forum/55-plugin-support/

2. **Include in Your Post:**
   - Plugin name and description
   - Link to GitHub repository
   - Installation instructions
   - Changelog
   - Screenshots (if applicable)

## Plugin URL Structure

Users will be able to install your plugin using:

```
https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg
```

Or through Community Applications by searching for "tmuxai"

## Maintaining Your Plugin

### Updating the Plugin

1. Make changes to your plugin
2. Update version number in `tmuxai.plg`
3. Update `CHANGELOG.md`
4. Commit and push to main branch
5. Users will be notified of updates through Community Applications

### Version Numbering

Use date-based versioning:
- Format: `YYYY.MM.DD`
- Example: `2024.12.29`

### Changelog Format

```xml
<CHANGES>
###YYYY.MM.DD
- Description of changes
- Bug fixes
- New features
</CHANGES>
```

## Best Practices

1. **Test Thoroughly**: Always test on a real Unraid system
2. **Document Well**: Keep README.md up to date
3. **Version Properly**: Update version and changelog with each release
4. **Respond to Issues**: Monitor GitHub issues and forum posts
5. **Keep Dependencies Minimal**: Minimize external dependencies
6. **Handle Errors**: Include error handling in scripts
7. **Preserve User Data**: Don't delete user configs on removal

## Support

- **Community Forums**: https://forums.unraid.net/
- **Community Apps**: https://github.com/Squidly271/AppFeed
- **Plugin Development**: https://wiki.unraid.net/UnRAID_Manual_6#Plugins

## Checklist

Before submitting:

- [ ] Plugin file is valid XML
- [ ] Installation script works correctly
- [ ] Removal script cleans up properly
- [ ] Icon is PNG format and displays correctly
- [ ] README.md is complete and accurate
- [ ] CHANGELOG.md is up to date
- [ ] Version number is current
- [ ] Tested on Unraid 6.9.0+
- [ ] Repository is public
- [ ] All files are on main branch
- [ ] No hardcoded paths that won't work on other systems
- [ ] Error handling is in place

## References

- [Unraid Plugin Documentation](https://wiki.unraid.net/UnRAID_Manual_6#Plugins)
- [Community Applications](https://forums.unraid.net/topic/38582-plug-in-community-applications/)
- [Plugin Development Guide](https://forums.unraid.net/topic/87144-plugin-development-guide/)
