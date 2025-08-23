#!/usr/bin/env bash

# Exit on any error and echo commands
set -euxo pipefail
# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Move into .devcontainer dir
cd .devcontainer

# Verify Java 17 is available
echo "Verifying Java installation..."
JAVA_VERSION=$(java -version 2>&1 | grep "openjdk version" | head -n 1 | awk '{print $3}' | sed 's/"//g' | cut -d'.' -f1)
if [[ "$JAVA_VERSION" == "17" ]]; then
    echo "✓ Java 17 is correctly installed"
else
    echo "✗ Java version mismatch. Expected: 17, Got: $JAVA_VERSION"
    exit 1
fi

# Install Android SDK
./installAndroidSdk.sh

# Install Flutter SDK
./installFlutterSdk.sh

# Return to previous dir
cd -
