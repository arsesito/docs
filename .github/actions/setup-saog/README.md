# Setup SAOG Action

A comprehensive GitHub Action for setting up the SAOG (Salvador Arturo Ortiz Gonzalez) environment with full configuration, dependency management, and validation.

**Author:** Salvador Arturo Ortiz Gonzalez (S.A.O.G.MX.)

## Features

✅ **Multi-environment support** - Development, Staging, Production  
✅ **Full validation** - Deno, configuration, permissions  
✅ **Comprehensive logging** - Debug, info, warn, error levels  
✅ **Performance metrics** - Setup time measurement  
✅ **Caching support** - Optional dependency caching  
✅ **Error handling** - Graceful error recovery  
✅ **Security** - Non-root Docker user, permission management  
✅ **GitHub Integration** - Native GitHub Actions outputs

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Deployment environment (dev, staging, production) | Yes | `dev` |
| `version` | SAOG version to set up | No | `latest` |
| `config-path` | Path to SAOG configuration file | No | `.saog/config.yml` |
| `enable-caching` | Enable dependency caching | No | `true` |
| `github-token` | GitHub token for API requests | No | `${{ github.token }}` |
| `verbose` | Enable verbose logging | No | `false` |

## Outputs

| Output | Description |
|--------|-------------|
| `status` | Setup status (success/failure) |
| `setup-time` | Time taken to complete setup in seconds |
| `environment` | Configured environment |
| `version` | Installed SAOG version |
| `deno-version` | Deno runtime version |

## Usage

### Basic Example

```yaml
name: Setup SAOG

on: [push, pull_request]

jobs:
  setup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup SAOG
        uses: ./.github/actions/setup-saog
        with:
          environment: dev
```

### Advanced Example

```yaml
name: Complete SAOG Setup

on: [push, pull_request]

jobs:
  setup:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup SAOG
        id: saog
        uses: ./.github/actions/setup-saog
        with:
          environment: production
          version: "1.0.0"
          config-path: ".saog/config.yml"
          enable-caching: "true"
          verbose: "true"
          github-token: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Display Setup Results
        run: |
          echo "Status: ${{ steps.saog.outputs.status }}"
          echo "Setup Time: ${{ steps.saog.outputs.setup-time }}s"
          echo "Environment: ${{ steps.saog.outputs.environment }}"
          echo "Deno Version: ${{ steps.saog.outputs.deno-version }}"
```

### Production Deployment

```yaml
name: Production Deployment

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup SAOG Production
        uses: ./.github/actions/setup-saog
        with:
          environment: production
          version: ${{ github.ref_name }}
          enable-caching: "true"
          verbose: "true"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Deploy
        run: deno run --allow-all deploy.ts
```

## Configuration

Create a `.saog/config.yml` file in your repository:

```yaml
name: SAOG Project
version: 1.0.0
environment: dev

settings:
  debug: false
  logging_level: info
  cache_enabled: true

services:
  - name: deno
    version: latest
    required: true
```

## Environment Variables

The action sets the following environment variables:

- `SAOG_READY` - Set to `true` when setup completes
- `SAOG_ENVIRONMENT` - The configured environment (dev, staging, production)
- `SAOG_VERSION` - The installed SAOG version
- `DENO_VERSION` - The Deno runtime version
- `SETUP_TIME` - Time taken to complete setup in seconds
- `SETUP_STATUS` - Final setup status (success/failure)

## Requirements

- **Docker** - The action runs in a Docker container
- **Deno** - Runtime environment (included in Docker image)
- **GitHub Actions** - Must be run in a GitHub Actions workflow

## Error Handling

The action includes comprehensive error handling:

1. **Validation errors** - Invalid environment, missing Deno
2. **Configuration errors** - Invalid YAML, missing files
3. **Permission errors** - Insufficient access rights
4. **Runtime errors** - Cache initialization, setup failures

All errors are logged with clear messages and exit codes.

## Troubleshooting

### "GITHUB_TOKEN is required for production environment"

**Solution:** Ensure `GITHUB_TOKEN` is passed in production:

```yaml
- name: Setup SAOG
  uses: ./.github/actions/setup-saog
  with:
    environment: production
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### "Deno is not installed or not in PATH"

**Solution:** This should not occur with the provided Docker image. Try rebuilding the action:

```bash
docker build -t setup-saog:latest .github/actions/setup-saog/
```

### Verbose Output

Enable verbose logging for debugging:

```yaml
- name: Setup SAOG
  uses: ./.github/actions/setup-saog
  with:
    verbose: "true"
```

## Performance

Expected setup times:

- **Development** - 5-10 seconds
- **Staging** - 10-15 seconds
- **Production** - 15-30 seconds (includes validation overhead)

## Security Considerations

- ✅ Non-root Docker user (deno)
- ✅ Read-only configuration in production
- ✅ GITHUB_TOKEN validation for production
- ✅ Secure permission management
- ✅ No hardcoded secrets

## License

This action is maintained by Salvador Arturo Ortiz Gonzalez (S.A.O.G.MX.)

## Support

For issues or questions, please open an issue in the repository:
https://github.com/arsesito/docs/issues