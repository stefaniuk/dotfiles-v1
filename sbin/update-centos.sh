#!/bin/bash

################################################################################

sudo yum --assumeyes update
sudo yum --assumeyes install

################################################################################

sudo yum clean packages

exit 0
