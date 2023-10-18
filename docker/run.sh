#!/bin/bash

# Check if the GCP_CREDS environment variable is set
if [ -z "$GCP_CREDS" ]; then
  # echo "Error: GCP_CREDS environment variable is not set."
  exit 1
fi

# Write the GCP_CREDS value to mycreds.json
echo "$GCP_CREDS" | base64 -d > mycreds.json

# Optionally, you can print the contents of mycreds.json for verification
# echo "Contents of mycreds.json:"
cat mycreds.json

gcloud auth login --cred-file=mycreds.json

gcloud config set project $GCP_PROJECT_ID

# Check if there are additional arguments (commands) passed to the script
if [ $# -eq 0 ]; then
  # echo "Error: No command provided. Usage: ./run.sh <command>"
  exit 1
fi

# Prepend "gcloud" to the provided command and execute it
# echo "Executing command: gcloud --format=json $@"
gcloud "$@" --format=json
