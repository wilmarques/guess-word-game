#!/usr/bin/env bash

# Dev Container onCreate script for Flutter 3.35.0 development environment
# Exit on any error and echo commands
set -euxo pipefail
# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Verify Java 17 installation
echo "Verifying Java 17 installation..."
if ! java -version 2>&1 | grep -q "openjdk version \"17"; then
    echo "ERROR: Java 17 is required but not found"
    java -version
    exit 1
fi
echo "✅ Java 17 verification successful"

# Move into .devcontainer dir
cd .devcontainer

# Install Android SDK
echo "Installing Android SDK..."
./installAndroidSdk.sh
if [ $? -ne 0 ]; then
    echo "ERROR: Android SDK installation failed"
    exit 1
fi

# Install Flutter SDK  
echo "Installing Flutter SDK..."
./installFlutterSdk.sh
if [ $? -ne 0 ]; then
    echo "ERROR: Flutter SDK installation failed"
    exit 1
fi

# Return to previous dir
cd -

echo "🎉 Dev Container setup completed successfully!"
echo "✅ Java 17 ready"
echo "✅ Android SDK API 34 ready"  
echo "✅ Flutter 3.35.0 ready"
