# GEMINI.md

This file provides guidance to Gemini CLI when working with code in this repository.

## Project Overview
This is a Docker containerization project for Gemini CLI, providing a containerized environment to run the Gemini CLI tool. The setup uses a Node.js slim base image and installs the official Gemini CLI package.

## Common Commands

### Building the Docker Image
```bash
docker build -t antonyho/docker-gemini-cli .
```

### Running the Container
```bash
# Run the container with proper permissions
docker run -it --rm \
    --name gemini-cli \
    --userns=host \
    -u $(id -u):$(id -g) \
    -v $(pwd):/workspace \
    -w /workspace \
    ghcr.io/antonyho/docker-gemini-cli
```

## Architecture Notes

### Docker Configuration
- Uses `node:current-slim` as base image for minimal footprint
- Installs Gemini CLI globally via npm
- Sets `gemini` as the default command
- Designed to mount host directories for persistent storage

### Volume Mounts
- `.gemini-cfg` directory is mounted to `/workspace` for Gemini CLI configuration persistence
- Current working directory is mounted to `/workspace` for code access
- Container runs with host user permissions to avoid file ownership issues

### Permission Handling
The Docker run command includes specific flags to handle file permissions:
- `--userns=host` disables user namespace isolation
- `-u $(id -u):$(id -g)` runs container with host user/group IDs
- These prevent permission issues when Gemini CLI creates files in mounted volumes
