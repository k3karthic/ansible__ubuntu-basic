# Ansible - Basic Setup for Ubuntu 20.04/Debian 11

The Ansible playbook in this repository does the following tasks on Ubuntu 20.04/Debian 11,
1. Update apt repositories
1. Install and configure fail2ban for SSH
2. Install daily rootkit detection scripts using chkrootkit and rkhunter
3. Install and configure swap space equal to total memory
4. Disable snapd for lower memory consumption
5. Install weekly script to update and reboot the system

The playbook assumes the instance runs in the Oracle Cloud using the terraform scripts below,
* terraform__oci-instance-1
    * GitHub: [github.com/k3karthic/terraform__oci-instance-1](https://github.com/k3karthic/terraform__oci-instance-1)
    * Codeberg: [codeberg.org/k3karthic/terraform__oci-instance-1](https://codeberg.org/k3karthic/terraform__oci-instance-1)
* terraform__oci-instance-2
    * GitHub: [github.com/k3karthic/terraform__oci-instance-2](https://github.com/k3karthic/terraform__oci-instance-2)
    * Codeberg: [codeberg.org/k3karthic/terraform__oci-instance-2](https://codeberg.org/k3karthic/terraform__oci-instance-2)

## Code Mirrors

* GitHub: [github.com/k3karthic/ansible__ubuntu-basic](https://github.com/k3karthic/ansible__ubuntu-basic/)
* Codeberg: [codeberg.org/k3karthic/ansible__ubuntu-basic](https://codeberg.org/k3karthic/ansible__ubuntu-basic/)

## Requirements

Install the following before running the playbook,
```
pip install oci
ansible-galaxy collection install oracle.oci
```

## Dynamic Inventory

The Oracle [Ansible Inventory Plugin](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/ansibleinventoryintro.htm) dynamically populates public Ubuntu instances.

The target Ubuntu instances must have the freeform tag `os: ubuntu`.

## Playbook Configuration

1. Update `inventory/oracle.oci.yml`,
    1. specify the region where you have deployed your server on Oracle Cloud.
    1. Configure the authentication as per the [Oracle Guide](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File).
1. Set username and ssh authentication in `inventory/group_vars/`.

To use more than a single SSH keypair (with passphrases), use ssh-agent to store them.

Run the following command to start `ssh-agent`,
```
eval "$(ssh-agent -s)"
```

Add each keypair using the following command,
```
ssh-add <path to keypair>
```

### Swap Configuration

The file `roles/swap/vars/main.yml` contains the following variables that you can change,
1. *swap_file_path*: File path for the swapfile. (Default: /swapfile.swap)
2. *swap_swappiness*: Kernel parameter to change how often it will use swap. (Default: 60)

## Deployment

Run the playbook using the following command,
```
./bin/apply.sh
```

## Encryption

Encrypt sensitive files (SSH private keys) before saving them. `.gitignore` must contain the unencrypted file paths.

Use the following command to decrypt the files after cloning the repository.

```
./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files.

```
./bin/encrypt.sh <gpg key id>
```
