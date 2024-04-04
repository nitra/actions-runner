FROM summerwind/actions-runner:v2.314.1-ubuntu-22.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install buildx
COPY --from=docker/buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
RUN docker buildx install

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
RUN sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN sudo apt update && \
    sudo apt-get install -y \
    nodejs \
    build-essential \
    google-cloud-sdk \
    libgtk2.0-0 libgtk-3-0 libgbm-dev libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libxtst6 xauth xvfb \
    libodbc1 \
    git-lfs \
    qemu \
    --no-install-recommends && \
    sudo npm install -g corepack

# додаємо depcheck щоб швидше запускався
RUN npx depcheck --version && \
    npx esbuild --version && \
    npx hasura-cli@2.36.2 version

RUN curl -sL firebase.tools | bash

RUN sudo rm -rf /var/lib/apt/lists/*
