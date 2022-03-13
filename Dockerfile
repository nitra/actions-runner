FROM summerwind/actions-runner:v2.288.1-ubuntu-20.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install:
# nodejs16, yarn, google-cloud-sdk
# libodbc1 для mssql npm пакета
# hadolint ignore=DL3004
# xvfb для кипра
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - 

RUN sudo apt-get update -y 

RUN sudo apt-get install -y \
    nodejs \
    google-cloud-sdk \
    libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    libodbc1 \
    git-lfs \
    qemu \
    --no-install-recommends 

RUN sudo npm install --global yarn

RUN curl -sL firebase.tools | bash

RUN sudo rm -rf /var/lib/apt/lists/* 


