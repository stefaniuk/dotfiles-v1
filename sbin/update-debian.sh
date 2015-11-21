#!/bin/bash

DEBIAN_FRONTEND="noninteractive"

################################################################################

sudo apt-get --yes update
sudo apt-get --yes upgrade

################################################################################

sudo apt-get --yes autoremove
sudo apt-get clean

exit 0
