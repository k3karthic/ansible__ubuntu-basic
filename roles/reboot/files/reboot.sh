#!/usr/bin/env bash

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends
reboot
