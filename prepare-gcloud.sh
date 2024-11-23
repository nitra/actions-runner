#!/bin/bash

gcloud auth configure-docker europe-west1-docker.pkg.dev,europe-west4-docker.pkg.dev,europe-north1-docker.pkg.dev,europe-central2-docker.pkg.dev,us-central1-docker.pkg.dev
gcloud auth activate-service-account --key-file=/service-account/github-actions.json
./run.sh
