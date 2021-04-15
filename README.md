# Ansible - Basic Setup for Ubuntu 20.04

## Deploy for Free

You can run two servers for free by using the [Oracle Cloud Always Free](https://www.oracle.com/cloud/free/#always-free) tier.

Terraform script for deploying a server in the free tier can be found at [https://github.com/k3karthic/terraform__oci-instance-1](https://github.com/k3karthic/terraform__oci-instance-1).

## Dynamic Inventory

This playbook uses the Oracle [Ansible Inventory Plugin](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/ansibleinventoryintro.htm) to dynamically populate public Ubuntu instances.

All public Ubuntu instances are assumed to have a freeform tag `os: ubuntu`.

## Configuration

1. Modify `inventory/oracle.oci.yml`
    1. specify the region where you have deployed your server on Oracle Cloud.
    1. Configure the authentication as per the [Oracle Guide](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File).
1. Set username and ssh authentication in `inventory/group_vars/all.yml`

### Swap Configuration

The file `roles/swap/vars/main.yml` contains the following variables that can be changed,
1. *swap_file_path*: File path where swapfile is stored. (Default: /swapfile.swap)
2. *swap_swappiness*: Kernel parameter to change how often swap is used. (Default: 60)

## Playbook Overview

This Ansible playbook performs the following tasks on an Ubuntu server,

1. Update apt repositories
1. Install and configure Fail2ban for SSH
1. Install and configure swap space equal to total memory

## Run

```
./bin/apply.sh
```

## Encryption

Sensitive files like the SSH private keys are encrypted before being stored in the repository.

The unencrypted file paths must be added to `.gitignore`.

Use the following command to decrypt the files after cloning the repository,

```
./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
./bin/encrypt.sh <gpg key id>
```
