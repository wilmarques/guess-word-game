#!/usr/bin/env bash

# Exit on any error
set -e
# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Move into .devcontainer dir
cd .devcontainer

# Install Android SDK
./installAndroidSdk.sh

# Install Google Chrome
./installGoogleChrome.sh

# Install Flutter SDK
./installFlutterSdk.sh

# Return to previous dir
cd -
