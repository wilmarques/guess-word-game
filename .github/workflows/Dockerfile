FROM ubuntu:focal
SHELL ["/bin/bash", "-c"]

############################################################
########################### MISC ###########################
############################################################

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update \
  && apt install -y apt-transport-https \
                    git \
                    unzip \
                    wget \
                    curl

############################################################
########################## LINUX ###########################
############################################################

# RUN apt install -y cmake

############################################################
######################### ANDROID ##########################
############################################################

# ENV ANDROID_HOME=$HOME/androidsdk
# ENV PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

# # Install Open JDK for android and other dependencies
# RUN apt install -y openjdk-8-jdk \
#                    libgtk-3-dev \
#                    libnss3-dev \
#                    fonts-noto \
#                    fonts-noto-cjk \
#   && update-java-alternatives --set java-1.8.0-openjdk-amd64

# # Install Android SDK Manager and Android 31
# RUN _file_name="commandlinetools-linux-8092744_latest.zip" && wget "https://dl.google.com/android/repository/$_file_name" \
#   && unzip "$_file_name" -d $ANDROID_HOME \
#   && rm -f "$_file_name" \
#   && mkdir -p $ANDROID_HOME/cmdline-tools/latest \
#   && mv $ANDROID_HOME/cmdline-tools/{bin,lib} $ANDROID_HOME/cmdline-tools/latest \
#   && yes | sdkmanager "platform-tools" "build-tools;31.0.0" "platforms;android-31"

############################################################
############################ WEB ###########################
############################################################

# Install Google Chrome

RUN apt install -y gnupg \
  && curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
  && apt update \
  && apt install -y google-chrome-stable

############################################################
######################### FLUTTER ##########################
############################################################

ENV FLUTTER_VERSION=3.7.5
ENV FLUTTER_HOME="$HOME/flutter"
RUN git clone https://github.com/flutter/flutter -b ${FLUTTER_VERSION} ${FLUTTER_HOME} --depth 1

ENV PATH="${FLUTTER_HOME}/bin:$PATH"
ENV PUB_CACHE="${FLUTTER_HOME}/.pub_cache"

ENV TAR_OPTIONS="--no-same-owner"

# Disable all platforms differente than web
RUN for _plat in linux-desktop windows-desktop macos-desktop android ios; \
      do flutter config --no-enable-${_plat}; \
    done
# Enable Flutter Web
RUN flutter config --enable-web
# Precache only Flutter Web, disabling anything else
RUN flutter precache web --no-ios --no-android --no-windows --no-linux --no-macos --no-fuchsia

RUN flutter doctor -v

ENTRYPOINT ["flutter"]
