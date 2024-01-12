# ansible-config

This repository holds all Ansible setup configurations for a variety of computers
and setups. Each Ansible playbook is for a specific application/purpose.

## Installation and Setup

```bash
# Update python tooling
python -m pip install --upgrade pip setuptools wheel virtualenv pipenv

# Add official ansible apt repository
sudo apt-add-repository -y ppa:ansible/ansible

# Install ansible
sudo apt install ansible sshpass -y

# For local development only:
pip install pre-commit && pre-commit install
```

## Ansible Vault Password

- Encrypted secrets and credentials are stored in local `secrets` directory and typically
  with a `.vault.yml` extension.
- In order for the playbook to use these secrets, you must provide the
  `ansible-playbook` command with the Ansible vault password.
- This can be passed either via a local file or via a environmental variable.
- To use a local file:
  1. Create a new file in this project's root directory named `ansible_vault_password.txt`

  - ```txt
      .
      ├── ......
      ├── ansible_vault_password.txt     <----- THIS
      ├── .git
      ├── README.md
      ├── secrets
      └── ......
      ```

  2. Within this new file add the Ansible vault password and nothing else.

  3. Save, exit, and reference this file via `--vault-password-file`

## Usage

- All playbooks are in the `playbooks` directory
- Run with `ansible-playbook` CLI tool with following syntax
- If changing the target host, remember to check `hosts` in playbook

  - ```bash
    ansible-playbook \
      --inventory <INVENTORY_FILEPATH> \          # <--- Note environment and hosts file
      --extra-vars "ansible_host=192.168.X.XXX" \ # <--- Remote target machine IP or localhost (not for local)
      --extra-vars "ansible_user=<USER>" \        # <--- Remote target machine login username
      --extra-vars "target_hosts=my_group" \      # <--- Targets group specified in hosts.ini
      --limit <INVENTORY_ITEM_HEADER> \           # <--- Specific item in inventory (ie. my_group)
      --vault-password-file <FILEPATH>            # <--- Filepath to file only containing ansible-vault password
      <PLAYBOOK_FILEPATH>                         # <--- Playbook file
    ```

- **Example:** Execute on a remote host

  - ```bash
    ansible-playbook \
      --inventory inventories/prod/hosts.ini \
      --extra-vars "ansible_host=192.168.X.XXX" \
      --extra-vars "ansible_user=billy" \
      --vault-password-file ./ansible_vault_password.txt \
      playbooks/<PLAYBOOK_NAME>.yml
    ```

- **Example:** Pull Repo and execute locally where Ansible is running

  - Ensure you have private SSH key to clone private repository
  - If needed, change credentials in `inventories/prod/hosts.ini`

  - ```bash
    git clone git@github.com:<GIT_ORG_NAME>/<GIT_REPO_NAME>
    cd <GIT_REPO_NAME>

    ansible-playbook \
      --inventory inventories/prod/hosts.ini \
      --extra-vars "target_hosts=localhost" \
      --extra-vars "ansible_user=billy" \
      --limit localhost \
      --vault-password-file ./ansible_vault_password.txt \
      playbooks/<PLAYBOOK_NAME>.yml
    ```

## Editing Ansible Vault Secrets

Encrypted ansible vault secrets can only be created, viewed, and edited
using the `ansible-vault` command.

```bash
ansible-vault edit <VAULT_FILEPATH>

# Example:
ansible-vault edit credentials/grub_password.yml
```

More info in [secrets directory](./secrets/)
