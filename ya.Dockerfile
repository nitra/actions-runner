FROM bitnami/kubectl AS kubectl

FROM ghcr.io/actions/actions-runner:2.330.0

ENV TZ="Europe/Riga"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

RUN sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl gnupg

# Node 24
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_24.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# YC
RUN curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
RUN sudo ln -s /home/runner/yandex-cloud/bin/docker-credential-yc /usr/local/bin/docker-credential-yc
RUN sudo ln -s /home/runner/yandex-cloud/bin/yc /usr/local/bin/yc

# Install
RUN sudo apt update && \
    sudo apt-get install -y \
    nodejs \
    zip \
    tzdata \
    --no-install-recommends

RUN sudo npm install -g corepack 
RUN curl -fsSL https://bun.com/install | bash

# RUN node --version && npm --version
# додаємо depcheck щоб швидше запускався
RUN npx -y depcheck --version && \
    npx -y oxlint --version && \
    npx -y eslint --version && \
    npx -y hasura-cli@2.36.2 version

RUN sudo rm -rf /var/lib/apt/lists/*

COPY prepare-ya.sh ./
