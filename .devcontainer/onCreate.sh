#!/usr/bin/env bash

# Exit on any error and echo commands
set -euxo pipefail
# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Verify Java 17 installation
echo "Verifying Java 17 installation..."
if ! java -version 2>&1 | grep -q "17\."; then
    echo "ERROR: Java 17 is not installed or not the active version" >&2
    java -version >&2
    exit 1
fi
echo "✅ Java 17 verified successfully"

# Move into .devcontainer dir
cd .devcontainer

# Install Android SDK
./installAndroidSdk.sh

# Install Flutter SDK
./installFlutterSdk.sh

# Return to previous dir
cd -
