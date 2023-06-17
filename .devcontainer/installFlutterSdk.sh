#!/usr/bin/env bash

# NOT DONE YET - WIP

# Install Flutter and its dependencies
# Ready for Android, Web and Linux desktop

# Go to $HOME
cd $HOME

#### Pre config environment
# Update apt packages
sudo apt update
# Install Flutter dependencies not available in the base image (Ubuntu)
sudo apt install -y xz-utils libglu1-mesa
# Install Flutter for Linux desktop dependencies not available in the base image (Ubuntu)
sudo apt install -y cmake clang ninja-build libgtk-3-dev

#### Install Flutter
# Set Flutter version to 3.10.3
export FLUTTER_VERSION="3.10.3"
# Set ANDROID_HOME variable to $HOME/.androidsdk
export FLUTTER_HOME=$HOME/.flutter
# Set ANDROID_HOME variable to $HOME/.androidsdk
export ANDROID_HOME=$HOME/.androidsdk # It will later be a env variable
# Download Flutter for Linux
wget "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION-stable.tar.xz" -O flutter.tar.xz
# Extract flutter.tar.xz
tar -xf flutter.tar.xz
# Remove flutter.tar.xz
rm -rf flutter.tar.xz
# Rename flutter dir to .flutter
mv flutter $FLUTTER_HOME
# Include a comment in bashrc to explain Flutter SDK
echo '# Flutter SDK' >> $HOME/.bashrc
# Add Flutter Home to bashrc
echo 'export FLUTTER_HOME="$HOME/.flutter"' >> $HOME/.bashrc
# Add flutter bin to PATH
echo 'export PATH="$FLUTTER_HOME/bin:$PATH"' >> $HOME/.bashrc
# Add flutter pub cache to PATH
echo 'export PUB_CACHE="/workspace/.pub_cache"' >> $HOME/.bashrc

#### Configuring Flutter platforms
# Enable Flutter Web
$FLUTTER_HOME/bin/flutter config --enable-web
# Enable Flutter Linux desktop
$FLUTTER_HOME/bin/flutter config --enable-linux-desktop
# Config Android SDK for Flutter
$FLUTTER_HOME/bin/flutter config --android-sdk $ANDROID_HOME
# Accept Flutter and Android licenses
yes | $FLUTTER_HOME/bin/flutter doctor --android-licenses
# Precache Flutter tools
$FLUTTER_HOME/bin/flutter precache

# Check if Flutter is working
$FLUTTER_HOME/bin/flutter doctor

# Return to previous dir
cd -
