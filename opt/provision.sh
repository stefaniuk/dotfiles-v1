#!/bin/bash
set -ex

# fix 'stdin: is not a tty' issue
sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

# set locale and timezone
apt-get --yes --force-yes --ignore-missing --no-install-recommends install \
    language-pack-en
locale-gen en_GB.UTF-8
update-locale LANG=en_GB.UTF-8 LC_CTYPE=en_GB.UTF-8
echo "Europe/London" | tee /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get --yes update
apt-get --yes install \
    docker-ce
usermod -aG docker vagrant

# set working directory
sed -i "/cd \/project/d" /home/vagrant/.bashrc
echo "cd /project" >> /home/vagrant/.bashrc
