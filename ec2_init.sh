#!/usr/bin/env bash

set -u
set -e

run_marker=/etc/ec2_configured

if [ -e $run_marker ]; then
    # Instance is already configured. Just exit.
    # If a user ever needs to remove this flag to rescue a machine,
    # Just mount the root disk on another instance and rm $run_marker
    exit
fi

su -c /etc/ec2_configure.sh vyos

touch $run_marker
