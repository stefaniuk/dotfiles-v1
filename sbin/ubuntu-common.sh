#!/bin/bash

DEBIAN_FRONTEND=noninteractive

apt_get_update="sudo apt-get --yes update"
apt_get_upgrade="sudo apt-get --yes upgrade"
apt_get_install="sudo apt-get --yes --ignore-missing --no-install-recommends install"
apt_add_repository="sudo add-apt-repository --yes"
