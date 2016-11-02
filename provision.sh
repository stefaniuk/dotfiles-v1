#!/bin/bash

# make '/project' work directory
sed -i "/cd \/project/d" /home/ubuntu/.bashrc
echo "cd /project" >> /home/ubuntu/.bashrc

exit 0
