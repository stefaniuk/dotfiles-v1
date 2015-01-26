#!/bin/bash

################################################################################
# bash

print_h2 "Configure system"

sudo $SHELL_COMMONS_HOME_DIR/bin/file_remove_str "Defaults[[:space:]]+env_reset" /etc/sudoers
sudo $SHELL_COMMONS_HOME_DIR/bin/file_remove_str "Defaults[[:space:]]+secure_path=\".*\"" /etc/sudoers

exit 0
