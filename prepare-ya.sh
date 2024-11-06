#!/bin/bash

yc container registry configure-docker
# gcloud auth activate-service-account --key-file=/service-account/github-actions.json
./run.sh
