# Ansible — Basic Setup for Ubuntu 22.04/Debian 11

The Ansible playbook in this repository performs the following tasks,
1. Update apt repositories
1. Install and configure fail2ban for SSH
2. Install daily rootkit detection scripts using chkrootkit and rkhunter
3. Install and configure swap space equal to total memory
4. Disable snapd on Ubuntu for lower memory consumption
5. Install weekly script to update and reboot the system

## Code Mirrors

* GitHub: [github.com/k3karthic/ansible__ubuntu-basic](https://github.com/k3karthic/ansible__ubuntu-basic/)
* Codeberg: [codeberg.org/k3karthic/ansible__ubuntu-basic](https://codeberg.org/k3karthic/ansible__ubuntu-basic/)

## Local Instance

### Configuration

The file `roles/swap/vars/main.yml` contains the following variables that you can change,
1. *swap_file_path*: File path for the swapfile. (Default: /swapfile.swap)
2. *swap_swappiness*: Kernel parameter to change how often it will use swap. (Default: 60)

### Deployment

Run the playbook using the following command,
```
$ ./bin/apply_local.sh
```

## Oracle Cloud Instance

**Assumption:** The instance runs in Oracle Cloud using either of the scripts below,
* terraform__oci-instance-1
    * GitHub: [github.com/k3karthic/terraform__oci-instance-1](https://github.com/k3karthic/terraform__oci-instance-1)
    * Codeberg: [codeberg.org/k3karthic/terraform__oci-instance-1](https://codeberg.org/k3karthic/terraform__oci-instance-1)
* terraform__oci-instance-2
    * GitHub: [github.com/k3karthic/terraform__oci-instance-2](https://github.com/k3karthic/terraform__oci-instance-2)
    * Codeberg: [codeberg.org/k3karthic/terraform__oci-instance-2](https://codeberg.org/k3karthic/terraform__oci-instance-2)
* terraform__oci-instance-3
    * GitHub: [github.com/k3karthic/terraform__oci-instance-3](https://github.com/k3karthic/terraform__oci-instance-3)
    * Codeberg: [codeberg.org/k3karthic/terraform__oci-instance-3](https://codeberg.org/k3karthic/terraform__oci-instance-3)

### Requirements

Install the following before running the playbook,
```
$ pip install oci
$ ansible-galaxy collection install oracle.oci
```

### Dynamic Inventory

The Oracle [Ansible Inventory Plugin](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/ansibleinventoryintro.htm) populates public Ubuntu instances.

All target Ubuntu instances must have the freeform tag `os: ubuntu`.

### Configuration

1. Update `inventory/oracle.oci.yml`,
    1. Specify the region where you have deployed your server on Oracle Cloud. List of regions are at [docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm).
    1. Configure the authentication as per the [Oracle Guide](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/sdkconfig.htm#SDK_and_CLI_Configuration_File)
1. Set username and ssh authentication in `inventory/group_vars/`

#### Swap

The file `roles/swap/vars/main.yml` contains the following variables that you can change,
1. *swap_file_path*: File path for the swapfile. (Default: /swapfile.swap)
2. *swap_swappiness*: Kernel parameter to change how often it will use swap. (Default: 60)

### Deployment

Run the playbook using the following command,
```
$ ./bin/apply.sh
```

## Encryption

Encrypt sensitive files (SSH private keys) before saving them. `.gitignore` must contain the unencrypted file paths.

Use the following command to decrypt the files after cloning the repository,

```
$ ./bin/decrypt.sh
```

Use the following command after running terraform to update the encrypted files,

```
$ ./bin/encrypt.sh <gpg key id>
```
