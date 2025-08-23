#!/usr/bin/env bash

# Install Flutter and its dependencies
# Ready for Android, Web and Linux desktop
# Depends on Java, Android SDK and Google Chrome pre-installed in devcontainer config
# See other scripts in .devcontainer dir

set -e

# Update apt packages
apt update
# Install Flutter dependencies not available in the base image (Ubuntu)
apt install -y xz-utils libglu1-mesa
# Install Flutter for Linux desktop dependencies not available in the base image (Ubuntu)
apt install -y cmake clang ninja-build libgtk-3-dev
# Reinstall cmake
apt install -y --reinstall cmake

# Include Android Home to PATH
export ANDROID_HOME="/usr/local/android"

# Set Flutter version to 3.10.3
export FLUTTER_VERSION="3.10.3"
echo "export FLUTTER_VERSION=${FLUTTER_VERSION}" >> /etc/bash.bashrc
# Set and create FLUTTER_HOME location path
export FLUTTER_HOME=/usr/local/flutter
echo "export FLUTTER_HOME=${FLUTTER_HOME}" >> /etc/bash.bashrc

# Download Flutter for Linux
wget "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz" -O flutter.tar.xz
# Extract flutter.tar.xz to $FLUTTER_HOME
tar -xf flutter.tar.xz -C /usr/local
# Remove flutter.tar.xz
rm -rf flutter.tar.xz

# Add Flutter to PATH
export PATH="$FLUTTER_HOME/bin:$PATH"
echo -e "export PATH=${FLUTTER_HOME}/bin:\$PATH" >> /etc/bash.bashrc
# Add Flutter pub cache to PATH
export PUB_CACHE="$FLUTTER_HOME/.pub_cache"
echo -e "export PUB_CACHE=${PUB_CACHE}" >> /etc/bash.bashrc
# Add Flutter Home to git safe directories
git config --global --add safe.directory $FLUTTER_HOME

# Enable Flutter Web
flutter config --enable-web
# Enable Flutter Linux desktop
flutter config --enable-linux-desktop
# Config Android SDK for Flutter
flutter config --android-sdk $ANDROID_HOME
# Accept Flutter and Android licenses
yes | flutter doctor --android-licenses
# Precache Flutter tools
flutter precache

# Check if Flutter is working
flutter doctor
