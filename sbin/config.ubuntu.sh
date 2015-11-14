#!/bin/bash

################################################################################
# locale

print_h2 "Configure locale"
sudo locale-gen en_GB.UTF-8
sudo dpkg-reconfigure locales

################################################################################

exit 0
