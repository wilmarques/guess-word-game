#!/usr/bin/env bash

# Update apt packages
apt update
# Install Chrome dependencies not available in the base image (Ubuntu)
apt install -y fonts-liberation libu2f-udev

# Disable sandbox to prevent Chrome from crashing
echo 'export QTWEBENGINE_DISABLE_SANDBOX=1' >> /etc/bash.bashrc

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
# Install downloaded file
sudo dpkg -i ./chrome.deb
# Delete downloaded file
rm -f chrome.deb

# Set CHROME_EXECUTABLE to Google Chrome location
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"
echo "export CHROME_EXECUTABLE=${CHROME_EXECUTABLE}" >> /etc/bash.bashrc
