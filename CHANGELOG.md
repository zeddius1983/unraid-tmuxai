# Changelog

All notable changes to the TmuxAI Unraid plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2026.02.12] - 2026-02-12

### Changed
- Updated tmuxai repository to github.com/alvinunreal/tmuxai (correct repository)
- Updated tmuxai version from v0.1.0 to v2.1.0 (latest release)
- Updated download URL to use correct releases page
- Changed download format from direct binary to tar.gz archive
- Updated architecture naming: `linux-amd64` → `Linux_amd64`, `linux-arm64` → `Linux_arm64`

### Fixed
- Fixed installation to download from correct GitHub repository
- Fixed download URL to match actual release format (tmuxai_Linux_amd64.tar.gz)
- Added proper tar.gz extraction and binary installation logic

## [2024.12.29] - 2024-12-29

### Added
- Initial release of TmuxAI plugin for Unraid
- Support for installing tmuxai CLI tool on Unraid systems
- Multi-architecture support (x86_64 and ARM64)
- Automatic dependency installation
- Configuration directory in /boot/config/plugins/tmuxai
- Plugin icon for Unraid WebGUI
- Comprehensive README with usage instructions
- Support for multiple AI providers (OpenAI, Anthropic, Google)
- Installation and removal scripts
- Persistent configuration across reboots

### Features
- Easy installation via Unraid Community Applications
- AI assistance directly in tmux sessions
- Support for various AI models
- Minimal footprint and resource usage

### Requirements
- Unraid 6.9.0 or later
- Internet connection for API access
- API key from supported AI provider
