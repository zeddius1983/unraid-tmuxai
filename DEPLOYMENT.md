# Deployment Guide for Repository Owner

This guide helps you deploy and maintain the TmuxAI Unraid plugin.

## Pre-Deployment Checklist

Before making the repository public or submitting to Community Apps:

- [x] All files committed to main branch
- [x] Plugin file tested and validated
- [x] Documentation is complete and accurate
- [x] License is in place
- [x] .gitignore excludes temporary files
- [ ] Test on actual Unraid system (highly recommended)
- [ ] Verify GitHub repository is public
- [ ] Check all URLs point to correct repository

## Repository Setup

### 1. Ensure Repository is Public

```bash
# Check repository visibility on GitHub
# Navigate to: Settings → General → Danger Zone → Change visibility
# Set to: Public
```

### 2. Enable GitHub Pages (Optional)

For hosting additional documentation:
- Go to Settings → Pages
- Source: Deploy from branch
- Branch: main / (root)

### 3. Configure Repository Settings

**Topics to add:**
- unraid
- plugin
- tmux
- ai
- tmuxai
- chatgpt
- claude
- unraid-plugin

**Description:**
"TmuxAI plugin for Unraid - Integrate AI capabilities into your tmux sessions"

**Website:**
https://github.com/zeddius1983/unraid-tmuxai

## Testing on Unraid

### Before Public Release

1. **Set up a test Unraid system** (VM or physical)

2. **Install the plugin manually:**
   ```bash
   # SSH to Unraid
   ssh root@your-unraid-ip
   
   # Download plugin
   wget https://raw.githubusercontent.com/zeddius1983/unraid-tmuxai/main/tmuxai.plg -O /boot/config/plugins/tmuxai.plg
   
   # Install
   installplg /boot/config/plugins/tmuxai.plg
   ```

3. **Test functionality:**
   ```bash
   # Check installation
   which tmuxai
   
   # Run setup
   bash /boot/config/plugins/tmuxai/setup.sh
   
   # Test with API key
   export OPENAI_API_KEY="your-test-key"
   tmuxai ask "test question"
   ```

4. **Test removal:**
   ```bash
   removepkg tmuxai
   
   # Verify cleanup
   ls /usr/local/bin/tmuxai  # Should not exist
   ls /boot/config/plugins/tmuxai/  # Config should remain
   ```

5. **Test reinstallation:**
   ```bash
   installplg /boot/config/plugins/tmuxai.plg
   ```

## Community Applications Submission

### Option 1: Via Pull Request (Recommended)

1. **Fork the AppFeed repository:**
   ```
   https://github.com/Squidly271/AppFeed
   ```

2. **Add your plugin** to the appropriate category file

3. **Create pull request** with:
   - Clear description
   - Link to your repository
   - Brief explanation of what tmuxai does

### Option 2: Forum Request

1. **Create account** on Unraid forums if you don't have one

2. **Post in Plugin Support:**
   https://forums.unraid.net/forum/55-plugin-support/

3. **Include in your post:**
   - Plugin name and description
   - Link to GitHub repository
   - Installation instructions
   - Why it's useful for Unraid users

## Monitoring and Maintenance

### GitHub Issues

Enable and monitor GitHub Issues:
- Settings → General → Features → Issues (checked)
- Respond to issues within 48-72 hours
- Label issues appropriately (bug, enhancement, question)

### Release Management

When creating updates:

1. **Update version** in tmuxai.plg:
   ```xml
   <!ENTITY version   "YYYY.MM.DD">
   ```

2. **Update CHANGELOG.md:**
   ```markdown
   ## [YYYY.MM.DD] - YYYY-MM-DD
   ### Added/Changed/Fixed
   - Description of changes
   ```

3. **Update CHANGES section** in tmuxai.plg:
   ```xml
   <CHANGES>
   ###YYYY.MM.DD
   - List of changes
   </CHANGES>
   ```

4. **Commit and push:**
   ```bash
   git add tmuxai.plg CHANGELOG.md
   git commit -m "Version YYYY.MM.DD - Description"
   git push origin main
   ```

5. **Tag the release** (optional but recommended):
   ```bash
   git tag -a v2024.12.29 -m "Initial release"
   git push origin v2024.12.29
   ```

### Update Notifications

When you update the plugin:
- Users with the plugin installed will see update notification in Unraid
- They can update via: Plugins → tmuxai → Update
- Or automatically if they have auto-update enabled

## Documentation Maintenance

### Keep Updated

- **README.md** - Main user-facing documentation
- **QUICKSTART.md** - Quick reference guide
- **EXAMPLES.md** - Usage examples
- **CHANGELOG.md** - Version history
- **COMMUNITY_APPS.md** - Submission guide

### When to Update Documentation

- New features added
- Bug fixes that change behavior
- New AI providers supported
- Changes to installation process
- User feedback indicates confusion

## Support Strategy

### GitHub Issues

Create issue templates:

**.github/ISSUE_TEMPLATE/bug_report.md**
```markdown
**Describe the bug**
A clear description of the bug.

**Unraid version:**
- Version: [e.g., 6.12.0]

**To Reproduce**
Steps to reproduce the behavior

**Expected behavior**
What you expected to happen

**Logs**
Any relevant logs from /var/log/tmuxai/
```

### Unraid Forums

- Create support thread once plugin is accepted
- Link to it from README.md
- Monitor regularly
- Cross-link GitHub issues and forum posts

## Common Maintenance Tasks

### Updating tmuxai Version

If tmuxai releases a new version:

1. Update download URL in tmuxai.plg
2. Test installation
3. Update version and changelog
4. Push to main

### Fixing Bugs

1. Create issue on GitHub
2. Fix in a branch
3. Test on Unraid
4. Merge to main
5. Update version

### Adding Features

1. Plan feature
2. Update documentation
3. Implement in tmuxai.plg or scripts
4. Test thoroughly
5. Update version and changelog
6. Release

## Analytics and Feedback

### Monitoring Usage

- Watch GitHub star count
- Monitor forum thread views/replies
- Track GitHub issues opened/closed
- Note Community Apps download stats (if available)

### Gathering Feedback

- Ask users in forum thread
- GitHub discussions (if enabled)
- Respond to issues and feature requests

## Security

### Regular Checks

- Monitor GitHub security advisories
- Review dependency security (if any)
- Keep scripts updated for best practices
- Respond quickly to security issues

### If Security Issue Found

1. Assess severity
2. Create patch immediately if critical
3. Update plugin ASAP
4. Notify users via forum post
5. Document in CHANGELOG

## Backup and Recovery

### Keep Backups

- Repository is on GitHub (automatic backup)
- Consider periodic local clones
- Document recovery procedures

### If Repository Compromised

1. Report to GitHub
2. Change credentials
3. Restore from backup
4. Notify community

## Long-term Maintenance

### Quarterly Tasks

- [ ] Review and update documentation
- [ ] Check for tmuxai updates
- [ ] Review open issues
- [ ] Update dependencies if any
- [ ] Test on latest Unraid version

### Annual Tasks

- [ ] Review plugin structure
- [ ] Consider major features
- [ ] Update screenshots if any
- [ ] Refresh documentation
- [ ] Evaluate user feedback

## Contact and Support

**Maintainer:** zeddius1983  
**GitHub:** https://github.com/zeddius1983  
**Repository:** https://github.com/zeddius1983/unraid-tmuxai  

## Resources

- [Unraid Plugin Development](https://wiki.unraid.net/UnRAID_Manual_6#Plugins)
- [Community Applications](https://forums.unraid.net/topic/38582-plug-in-community-applications/)
- [Unraid Forums](https://forums.unraid.net/)

---

**Deployment Status:** Ready ✅  
**Last Updated:** 2024-12-29
