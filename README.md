# Basic Setup for Ubuntu 20.04

## Configuration

Modify `inventory/oracle.oci.yml` and specify the region where you have deployed your server on Oracle Cloud.

Configure the authentication as per the [Oracle Guide](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File).

## SSH Private Key

Copy your SSH private key for your server into the `ssh` folder as `oracle`. Alternatively, edit the `inventory/group_vars/all.yml` file and replace the value of `ansible_ssh_private_key_file` with the location of the private key.

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

Use the following command to decrypt the files after cloning the repository,

```
./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
./bin/encrypt.sh <gpg key id>
```
