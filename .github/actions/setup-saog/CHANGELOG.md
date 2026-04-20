# Changelog

All notable changes to the Setup SAOG Action will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-04-20

### Added
- Comprehensive error handling with trap functions
- Verbose logging mode for debugging
- Configuration validation (YAML structure check)
- Permission management for production environments
- Deno cache warming functionality
- Performance metrics (setup time measurement)
- Health checks in Docker image
- Multi-stage Docker build for optimized image size
- Detailed setup summary with formatted output
- Support for custom GitHub tokens
- Caching toggle with DENO_DIR configuration
- Full documentation with examples

### Improved
- Enhanced logging with color-coded output levels
- Better input parameter validation
- Production environment security requirements
- Deno version detection and display
- Error messages with actionable guidance
- Script organization with clear sections
- Docker image security (non-root user, health checks)

### Fixed
- Missing environment variable exports
- Incomplete output definitions
- Missing production validation
- Docker security vulnerabilities

### Changed
- Migrated from basic setup to comprehensive environment configuration
- Updated Dockerfile with multi-stage build
- Enhanced action.yml with all necessary inputs/outputs
- Restructured entrypoint.sh with proper error handling

## [1.0.0] - 2026-04-19

### Initial Release
- Basic SAOG environment setup
- Deno version checking
- Simple environment configuration
- Docker-based action execution
