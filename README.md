# Ansible - Basic Setup for Ubuntu 20.04

The Ansible playbook in this repository performs the following tasks on an Ubuntu 20.04 instance,
1. Update apt repositories
1. Install and configure Fail2ban for SSH
1. Install and configure swap space equal to total memory
1. Disable snapd for lower memory consumption

The playbook assumes the instance runs in Oracle Cloud using the terraform scripts below,
* [https://github.com/k3karthic/terraform__oci-instance-1](https://github.com/k3karthic/terraform__oci-instance-1).
* [https://github.com/k3karthic/terraform__oci-instance-2](https://github.com/k3karthic/terraform__oci-instance-2).

## Requirements

Install the following Ansible modules before running the playbook,
```
ansible-galaxy collection install oracle.oci
```

## Dynamic Inventory

This playbook uses the Oracle [Ansible Inventory Plugin](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/ansibleinventoryintro.htm) to populate public Ubuntu instances dynamically.

All public Ubuntu instances are assumed to have a freeform tag `os: ubuntu`.

## Playbook Configuration

1. Modify `inventory/oracle.oci.yml`
    1. specify the region where you have deployed your server on Oracle Cloud.
    1. Configure the authentication as per the [Oracle Guide](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File).
1. Set username and ssh authentication in `inventory/group_vars/`

If you are using mutliple SSH key pairs, use the following command to add them to ssh-agent before running the playbook.
```
eval "$(ssh-agent -s)"
ssh-add <path to keypair>
```

### Swap Configuration

The file `roles/swap/vars/main.yml` contains the following variables that you can change,
1. *swap_file_path*: File path where swapfile is stored. (Default: /swapfile.swap)
2. *swap_swappiness*: Kernel parameter to change how often swap is used. (Default: 60)

## Deployment

Run the playbook using the following command,
```
./bin/apply.sh
```

## Encryption

Sensitive files like the SSH private keys are encrypted before being stored in the repository.

You must add the unencrypted file paths to `.gitignore`.

Use the following command to decrypt the files after cloning the repository,

```
./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
./bin/encrypt.sh <gpg key id>
```
