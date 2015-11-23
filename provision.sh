#!/bin/bash

# fix 'stdin: is not a tty' issue
sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

# install 'dotfiles'
curl -L https://raw.githubusercontent.com/stefaniuk/dotfiles/master/setup.sh -o - | /bin/bash -s -- \
    --update \
    --install --install-common-tools \
    --config \
    --minimal

# make '/project' work directory
echo "cd /project" > /home/vagrant/.bash_custom

# run all tests
cd /project
make all OS=ubuntu
make all OS=debian
make all OS=centos
make all OS=scientific

exit 0
