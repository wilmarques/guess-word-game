FROM ubuntu:focal
SHELL ["/bin/bash", "-c"]

############################################################
##################### DEPENDENCIES #########################
############################################################

# Disable interactivity during Docker run
ENV DEBIAN_FRONTEND=noninteractive
# Disable Same Owner check during tar operations
ENV TAR_OPTIONS="--no-same-owner"

# Install all the dependencies needed for Chrome, Flutter, etc
RUN apt update \
  && apt install -y apt-transport-https \
                    git \
                    unzip \
                    wget \
                    curl \
                    gnupg

# Install Google Chrome
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt update \
  && apt install -y google-chrome-stable

############################################################
######################### FLUTTER ##########################
############################################################

# Choose Flutter version
ENV FLUTTER_VERSION=3.7.5
# Set Flutter Home dir
ENV FLUTTER_HOME="$HOME/flutter"
# Include Flutter Home dir in $PATH, so flutter can be run as a command
# Instead of running it using the absolute path
# Eg: flutter run ...
ENV PATH="${FLUTTER_HOME}/bin:$PATH"
# Configure where pub will save its cache
# Also the global dependencies will be stored here
ENV PUB_CACHE="${FLUTTER_HOME}/.pub_cache"
# Include Pub Cache dir in $PATH
# So global dependencies can be run through `pub`
# Instead of making them available only through flutter cli
ENV PATH="${FLUTTER_HOME}/bin:$PATH"

# Clone Flutter on the FLUTTER_HOME
RUN git clone https://github.com/flutter/flutter -b ${FLUTTER_VERSION} ${FLUTTER_HOME} --depth 1
# Disable all platforms differente than Flutter Web
RUN for _plat in linux-desktop windows-desktop macos-desktop android ios; \
      do flutter config --no-enable-${_plat}; \
    done
# Enable Flutter Web
RUN flutter config --enable-web
# Precache only Flutter Web, ignoring other platforms
RUN flutter precache web --no-ios --no-android --no-windows --no-linux --no-macos --no-fuchsia
# Check if everything is ok and precompile Flutter
RUN flutter doctor -v

# Configure Flutter as the entrypoint, so this image can be used like:
# docker run <docker options> <flutter command>
# Eg: `docker run .... doctor`
ENTRYPOINT ["flutter"]
