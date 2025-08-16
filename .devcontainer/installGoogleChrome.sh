#!/usr/bin/env bash

# Update apt packages
apt-get update
# Install Chrome dependencies not available in the base image (Ubuntu)
apt-get install -y fonts-liberation libu2f-udev

# Disable sandbox to prevent Chrome from crashing
echo 'export QTWEBENGINE_DISABLE_SANDBOX=1' >> /etc/bash.bashrc

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
# Install downloaded file (no sudo needed inside container)
dpkg -i /tmp/chrome.deb || apt-get install -f -y
# Delete downloaded file
rm -f /tmp/chrome.deb

# Set CHROME_EXECUTABLE to Google Chrome location
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
echo "export CHROME_EXECUTABLE=${CHROME_EXECUTABLE}" >> /etc/bash.bashrc
