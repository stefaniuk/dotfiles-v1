#!/bin/bash

print_h2 "Lists of packages"
$apt_get_update
print_h2 "Packages"
$apt_get_upgrade
