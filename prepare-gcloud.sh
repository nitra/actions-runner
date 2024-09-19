#!/bin/bash

gcloud auth configure-docker europe-west4-docker.pkg.dev,europe-north1-docker.pkg.dev
gcloud auth activate-service-account github-actions@abie-ua.iam.gserviceaccount.com --key-file=/service-account/github-actions.json
