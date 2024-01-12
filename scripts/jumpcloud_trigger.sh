#!/bin/bash

#####################################################################
# This script can be used to trigger a JumpCloud command from
# the command line. This allows the execution of any
# command in any JumpCloud system.
#
# IMPORTANT:
#     - Ensure that your JumpCloud API key is set in the environment
#     -    source JUMPCLOUD_API_KEY="<MY_API_KEY>"
#
# Usage:
#     ./jumpcloud_trigger.sh <TRIGGER_NAME> <GIT_BRANCH> <ANSIBLE_PLAYBOOK>
#     ./jumpcloud_trigger.sh ansibleRun master _testing.yml
#
# Ismet Handzic - 12/25/2023
######################################################################

set -eu
set -o pipefail

# Define trigger name
DEFAULT_TRIGGER_NAME="ansibleRun"

######################################################################

# Use first script argument as trigger name if provided
TRIGGER_NAME="${1:-$DEFAULT_TRIGGER_NAME}"
GIT_BRANCH="${2:-}"
ANSIBLE_PLAYBOOK="${3:-}"

# Ensure both GIT_BRANCH and ANSIBLE_PLAYBOOK are provided
if [ -z "$GIT_BRANCH" ] || [ -z "$ANSIBLE_PLAYBOOK" ]; then
    echo "ERROR: GIT_BRANCH and ANSIBLE_PLAYBOOK must be provided." >&2
    exit 1
fi

# Read API Key from Environment Variable
JUMPCLOUD_API_KEY="${JUMPCLOUD_API_KEY:-}"
if [ -z "$JUMPCLOUD_API_KEY" ]; then
    echo "ERROR: JUMPCLOUD_API_KEY is not set locally." >&2
    exit 1
fi

# Define the JSON string
ENV_VARS_INJECTED='{
  "JC_GIT_BRANCH": "'"$GIT_BRANCH"'",
  "JC_ANSIBLE_PLAYBOOK": "'"$ANSIBLE_PLAYBOOK"'"
}'

echo "Adding the following environmental variables to command:"
echo "${ENV_VARS_INJECTED}"

echo "Triggering ${TRIGGER_NAME} ..."
curl --silent \
  -X 'POST' \
  -H "x-api-key: ${JUMPCLOUD_API_KEY}" \
  -H 'Content-Type: application/json' \
  -d "$ENV_VARS_INJECTED" \
"https://console.jumpcloud.com/api/command/trigger/${TRIGGER_NAME}"

echo
echo "DONE"
