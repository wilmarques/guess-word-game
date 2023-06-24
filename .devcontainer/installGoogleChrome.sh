#!/bin/sh

# NOT DONE YET - WIP

# Go to $HOME
cd $HOME

# Disable sandbox to prevent Chrome from crashing
echo 'export QTWEBENGINE_DISABLE_SANDBOX=1' >> /etc/bash.bashrc

# Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
# Install downloaded file
sudo dpkg -i ./chrome.deb
# Delete downloaded file
rm -f chrome.deb

# Return to previous directory
cd -
