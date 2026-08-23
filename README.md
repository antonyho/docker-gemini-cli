# Gemini CLI in Docker Container

A Docker containerization of the Gemini CLI tool for easy deployment and consistent environment setup.

## Prerequisites

- Docker installed and running
- Google account or API key for Gemini authentication

## Quick Start

### Using the Pre-built Image

```bash
# Run Gemini CLI in Docker
docker run -it --rm \
    --name gemini-cli \
    --userns=host \
    -u $(id -u):$(id -g) \
    -v $(pwd):/workspace \
    -w /workspace \
    ghcr.io/antonyho/docker-gemini-cli
```

### Building Your Own Image

If you prefer to build the image yourself: (replace my namespace "antonyho" with yours)

```bash
# Build the image
docker build -t antonyho/docker-gemini-cli .
```

## How It Works

### First Launch Setup
On first launch, Gemini CLI will:
1. Prompt you to sign in with your Google account or API key
2. Create a `.gemini-cfg` directory in your current workspace

### Directory Structure
- Current directory - Mounted to `/workspace` for code access
- `.gemini-cfg` directory will be initialised by Gemini CLI on first launch

*Consider adding the `.gemini-cfg` directory to your project's `.gitignore` to keep your user secret and settings private.*

### Permission Handling
The Docker run command includes specific flags to handle file permissions:
- `--userns=host` - Disables user namespace isolation
- `-u $(id -u):$(id -g)` - Runs container with your host user/group IDs

This prevents permission issues when Gemini CLI creates files in mounted volumes.
**You are very likely that you don't need them if you have not configured user namespace on your Docker service.**
