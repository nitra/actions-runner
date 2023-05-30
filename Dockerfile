FROM summerwind/actions-runner:v2.304.0-ubuntu-22.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# webpack 4 - doesn't support node 18
# ENV NODE_OPTIONS=--openssl-legacy-provider

# Install:
# nodejs18, yarn, google-cloud-sdk
# libodbc1 для mssql npm пакета
# hadolint ignore=DL3004
# xvfb для кипра
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -

# kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && sudo touch /etc/apt/sources.list.d/kubernetes.list \
    && echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

RUN sudo apt-get update -y && \
    sudo apt-get install -y \
    nodejs \
    build-essential \
    google-cloud-sdk \
    libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    libodbc1 \
    git-lfs \
    qemu \
    kubectl \
    --no-install-recommends

# додаємо depcheck щоб швидше запускався
RUN sudo npm install --global yarn && \
    npx depcheck --version

RUN curl -sL firebase.tools | bash

RUN sudo rm -rf /var/lib/apt/lists/*
