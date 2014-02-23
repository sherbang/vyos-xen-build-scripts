#!/usr/bin/env bash

set -u
set -e

echo "VyOS EC2 first boot configuration starting."

aws_api='2012-01-12'

grep hypervisor /proc/cpuinfo &> /dev/null || (echo "This doesn't look like AWS" && exit 1)

# API use based on documentation at http://wiki.het.net/wiki/Cli-shell-api

# Set up a configuration session
session_env=$(cli-shell-api getSessionEnv $PPID)
eval $session_env
cli-shell-api setupSession

# Put handy commands into shorthand
export vyatta_sbindir=/opt/vyatta/sbin
SET=${vyatta_sbindir}/my_set
DELETE=${vyatta_sbindir}/my_delete
COMMIT=${vyatta_sbindir}/my_commit

echo "Loading SSH key for user vyos:"
$vyatta_sbindir/vyatta-load-user-key.pl vyos http://169.254.169.254/$aws_api/meta-data/public-keys/0/openssh-key
$SET service ssh disable-password-authentication

echo "Setting up consoles"
$DELETE system console device ttyS0
$SET system console device hvc0 speed 9600

echo "Setting hostname."
$SET system host-name `curl -s http://169.254.169.254/$aws_api/meta-data/public-hostname/ | cut -d. -f1`

echo "Committing configuration."
$COMMIT

echo "Saving configuration."
$vyatta_sbindir/vyatta-save-config.pl

cli-shell-api teardownSession

echo "VyOS EC2 first boot configuration complete."
