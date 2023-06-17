#!/usr/bin/env bash

# Install Android SDK and its dependencies
# Depends on Java pre-installed in devcontainer config

ANDROID_PLATFORM_VERSION="30"
ANDROID_BUILD_TOOLS_VERSION="30.0.3"

# Include Android Home to PATH
export ANDROID_HOME="/usr/local/android"
echo "export ANDROID_HOME=${ANDROID_HOME}" >> /etc/bash.bashrc
COMMAND_LINE_TOOLS_PATH=${ANDROID_HOME}/cmdline-tools/latest
mkdir -p $ANDROID_HOME

# Include Android SDK tools to PATH
ANDROID_SDK_TOOLS_PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:${COMMAND_LINE_TOOLS_PATH}/bin:$ANDROID_HOME/platform-tools"
export PATH="${ANDROID_SDK_TOOLS_PATH}:$PATH"
echo -e "export PATH=${ANDROID_SDK_TOOLS_PATH}:\$PATH" >> /etc/bash.bashrc

# Download Android SDK Manager CLI, extract to Android Home and delete temp file
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O sdkmanager.zip
unzip sdkmanager.zip -d $ANDROID_HOME
rm -rf sdkmanager.zip
mkdir -pv $COMMAND_LINE_TOOLS_PATH
mv $ANDROID_HOME/cmdline-tools/bin $COMMAND_LINE_TOOLS_PATH
mv $ANDROID_HOME/cmdline-tools/lib $COMMAND_LINE_TOOLS_PATH

# Enable Android Platform Tools and Build Tools
yes | sdkmanager "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" "platforms;android-${ANDROID_PLATFORM_VERSION}"
# Accept Android licenses (required for sdkmanager)
yes | sdkmanager --licenses
