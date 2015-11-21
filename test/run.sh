#!/bin/bash

./setup.sh \
    --prepare \
    --install \
    --install-system-tools \
    --install-common-tools \
    --install-server-tools \
    --install-workstation-tools \
    --config
/bin/bash -cli "system_test --skip-selected-tests"

exit 0
