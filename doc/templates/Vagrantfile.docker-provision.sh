#!/bin/bash

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

# clean up Docker containers and images
docker rm -v $(docker ps -a -q -f status=exited) > /dev/null 2>&1
docker rmi $(docker images -f "dangling=true" -q) > /dev/null 2>&1
# start Docker containers
cd /project
make all

exit 0
