FROM summerwind/actions-runner:v2.314.1-ubuntu-22.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# webpack 4 - doesn't support node 18.
# ENV NODE_OPTIONS=--openssl-legacy-provider

# Node 20
RUN sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl gnupg
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Install:
# yarn, google-cloud-sdk
# libodbc1 для mssql npm пакета
# hadolint ignore=DL3004
# xvfb для кипра
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add -

# kubectl
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    sudo touch /etc/apt/sources.list.d/kubernetes.list \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

RUN sudo apt update && \
    sudo apt-get install -y \
    nodejs \
    build-essential \
    google-cloud-sdk \
    libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    libodbc1 \
    git-lfs \
    qemu \
    kubectl \
    --no-install-recommends && \
    sudo npm install -g corepack

# додаємо depcheck щоб швидше запускався
RUN npx depcheck --version && \
    npx esbuild --version && \
    npx hasura-cli@2.36.2 --version

RUN curl -sL firebase.tools | bash

RUN sudo rm -rf /var/lib/apt/lists/*
