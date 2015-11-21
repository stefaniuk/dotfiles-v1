#!/bin/bash

./setup.sh \
    --prepare \
    --install \
    --install-system-tools \
    --install-common-tools \
    --install-server-tools \
    --install-workstation-tools \
    --config \
    --test \
    --minimal

exit 0
