#!/bin/bash

# TODO: Install 'dotfiles'

# fix 'stdin: is not a tty' issue
sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

# set locale and timezone
apt-get install language-pack-en
locale-gen en_GB.UTF-8
update-locale LANG=en_GB.UTF-8 LC_CTYPE=en_GB.UTF-8
echo "Europe/London" | tee /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# make '/project' work directory
sed -i "/cd \/project/d" /home/vagrant/.bashrc
echo "cd /project" >> /home/vagrant/.bashrc

# build Docker test images
cd /project
make build OS=ubuntu
make build OS=debian
make build OS=centos
make build OS=scientific

exit 0
