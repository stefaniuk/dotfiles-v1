#!/bin/bash

################################################################################

sudo yum --assumeyes update
sudo yum --assumeyes install epel-release

################################################################################

sudo yum clean packages

exit 0
