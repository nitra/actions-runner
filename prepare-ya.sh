#!/bin/bash

yc config profile create github-actions
yc config set service-account-key /service-account/github-actions.json
yc config set cloud-id b1g5ld4jd5bkt80mpv6b
yc config set folder-id b1gh9adr678gi95acvdg
yc container registry configure-docker

/home/runner/run.sh

#
