#!/bin/bash

################################################################################
# Bash

print_h2 "Configure system"

sudo $SHELL_COMMONS_HOME/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
sudo $SHELL_COMMONS_HOME/bin/file_remove_str "Defaults[[:space:]]+secure_path[[:space:]]+=[[:space:]]+.*" /etc/sudoers

################################################################################

exit 0
