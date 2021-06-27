#!/usr/bin/env bash

/usr/bin/apt-get update
DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get upgrade -y --no-install-recommends
/usr/sbin/reboot
