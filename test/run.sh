#!/bin/bash

./setup.sh --config
/bin/bash -cli "system_test --skip-selected-tests"

exit 0
