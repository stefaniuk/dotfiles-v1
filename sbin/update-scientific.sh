#!/bin/bash

yum_install="sudo yum --assumeyes install"

################################################################################

sudo yum --assumeyes update
$yum_install epel-release

################################################################################

sudo yum clean packages

exit 0