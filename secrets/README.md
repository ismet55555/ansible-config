# secrets

The following are the secrets files:

- `my_group` - Sudo and SSH password for user running Ansible
- `grub_credentials` - Grub credentials
- `jumpcloud_connect_key` - JumpCloud connect key to add device to JumpCloud
- `localhost` - Sudo password for user running Ansible
- `root` - Root user login password

## Changing Ansible-Vault Password

This is to change the password to the Ansible vault file itself.

```bash
ansible-vault rekey <VAULT_FILEPATH>

# Example:
ansible-vault rekey secrets/grub_password.yml
# Vault password:
# New Vault password:
# Confirm New Vault password:
# Rekey successful
```
