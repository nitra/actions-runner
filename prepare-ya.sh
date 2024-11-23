#!/bin/bash

/home/runner/yandex-cloud/bin/yc config profile create github-actions
/home/runner/yandex-cloud/bin/yc config set service-account-key /service-account/github-actions.json
/home/runner/yandex-cloud/bin/yc config set cloud-id b1g5ld4jd5bkt80mpv6b
/home/runner/yandex-cloud/bin/yc config set folder-id b1gh9adr678gi95acvdg
/home/runner/yandex-cloud/bin/yc container registry configure-docker

/home/runner/run.sh