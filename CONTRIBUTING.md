# Contributing to unraid-tmuxai

Thank you for your interest in contributing to the TmuxAI Unraid plugin!

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- A clear description of the problem
- Steps to reproduce
- Your Unraid version
- Any relevant logs from `/var/log/tmuxai/`

### Suggesting Enhancements

We welcome feature requests! Please open an issue with:
- A clear description of the enhancement
- Why this would be useful
- Any examples of how it would work

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test on an Unraid system if possible
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Development Guidelines

#### Plugin File (.plg)
- Follow Unraid plugin conventions
- Test installation and removal scripts
- Update version number and changelog
- Ensure compatibility with Unraid 6.9.0+

#### Scripts
- Use `#!/bin/bash` shebang
- Add error handling with `set -e`
- Include helpful echo messages
- Test on both x86_64 and ARM64 if possible

#### Documentation
- Update README.md for user-facing changes
- Update CHANGELOG.md following [Keep a Changelog](https://keepachangelog.com/)
- Add comments for complex logic

### Testing

Before submitting a PR, please test:
1. Fresh installation
2. Upgrade from previous version
3. Configuration changes
4. Removal/uninstallation
5. Compatibility with tmux

### Code Style

- Use 2 spaces for indentation in shell scripts
- Use meaningful variable names
- Follow existing code patterns
- Add comments for non-obvious code

## Questions?

Feel free to open an issue for any questions about contributing!
