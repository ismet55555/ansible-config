#!/bin/bash

#####################################################################
# This script is the base for executing a Ansible playbook from
# the Ansible repository. This allows the execution of any
# playbook in any git branch.
#
# IMPORTANT:
#     - Run this script as root on JumpCloud Command
#
# Variables Used:
#     - JC_GIT_BRANCH       - Git branch to execute Ansible playbook from (ie. dev, main)
#     - JC_ANSIBLE_PLAYBOOK - Playbook in the playbook directory (ie. _testing.yml)
#
# Required:
#     - Upload the private SSH key used to clone Ansible git repo
#       into JumpCloud Command Details into file destination
#       as `/root/.ssh/id_rsa` (no extension)
#
# Ismet Handzic - 12/19/2023
######################################################################

set -eu
set -o pipefail


REPO_NAME="<GIT_REPO_NAME>"
REPO_ORG="<GIT_ORG_NAME>"
REPO_URL="git@github.com:${REPO_ORG}/${REPO_NAME}.git"
REPO_GIT_DIR="/root/${REPO_NAME}/.git"
LOGGER_TAG="JUMPCLOUD-ANSIBLE"

# Files injected by JumpCloud Command
SSH_KEY_FILE="/root/.ssh/id_rsa"
ANSIBLE_VAULT_PASSWORD_FILE="/tmp/ansible_vault_password.txt"

######################################################################

log_message() {
    # USAGE: log_message "message" [level] [message_tag]
    # Levels: debug, info, notice, warning, err, crit, alert, emerg
    local level=${2:-info}
    local message_tag="${3:-$LOGGER_TAG}"
    logger -p local0."$level" -t "$message_tag" "$1" && echo "$1"
}

clean_jc_variable() {
    # Removes surrounding single or double quotes from the input
    local cleaned="${1#\"}"      # Remove leading double quote
    cleaned="${cleaned%\"}"      # Remove trailing double quote
    echo "$cleaned"
}

dividing_line() {
    echo
    echo "--------------------------------------------------------"
}

######################################################################

# Clean JumpCloud variables for double quotes
JC_GIT_BRANCH_CLEAN=$(clean_jc_variable "$JC_GIT_BRANCH")
JC_ANSIBLE_PLAYBOOK_CLEAN=$(clean_jc_variable "$JC_ANSIBLE_PLAYBOOK")

# Potentially missing .ssh directory
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"

# Fix file permissions from JumpCloud injection
chmod 600 $SSH_KEY_FILE
chmod 600 $ANSIBLE_VAULT_PASSWORD_FILE

# Adding github.com to known_hosts
ssh-keyscan -H github.com >> /root/.ssh/known_hosts

######################################################################


log_message "*** JumpCloud Script START ***"

dividing_line
cd /root
if [ ! -d $REPO_GIT_DIR ]
then
    log_message "Cloning Ansible git repository '${REPO_URL}' ..."
    git clone $REPO_URL
    cd $REPO_NAME
else
    log_message "Ansible git repository already exists locally. Removing any local changes ..."
    cd $REPO_NAME
    git restore .
    git checkout main
fi
log_message "Fetching git repo ..."
git fetch


log_message "Switching git branch to '${JC_GIT_BRANCH_CLEAN}'..."
git checkout "${JC_GIT_BRANCH_CLEAN}"
git pull origin "${JC_GIT_BRANCH_CLEAN}"

echo "Last git commit on this branch:"
git log -1 | cat -


#######################################################


dividing_line
echo "Contents of used Ansible playbook file '${JC_ANSIBLE_PLAYBOOK_CLEAN}':"
cat "playbooks/${JC_ANSIBLE_PLAYBOOK_CLEAN}"
echo
log_message "Running Ansible playbook '${JC_ANSIBLE_PLAYBOOK_CLEAN}' ..."
ansible-playbook \
  --inventory inventories/prod/hosts.ini \
  --extra-vars "target_hosts=localhost" \
  --limit localhost \
  --vault-password-file $ANSIBLE_VAULT_PASSWORD_FILE \
  playbooks/"${JC_ANSIBLE_PLAYBOOK_CLEAN}"


#######################################################


dividing_line
log_message "Removing Ansible git repository ..."
# rm -rf /root/$REPO_NAME

log_message "Removing private SSH key ..."
rm $SSH_KEY_FILE

log_message "Removing Ansible Vault password file ..."
rm $ANSIBLE_VAULT_PASSWORD_FILE

echo
log_message "*** JumpCloud Script SUCCESSFUL ***"
