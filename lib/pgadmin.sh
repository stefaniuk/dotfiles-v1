#!/bin/bash

print_h2 "pgAdmin"

if [ $DIST = "ubuntu" ]; then
    $apt_get_install \
        pgadmin3
fi
