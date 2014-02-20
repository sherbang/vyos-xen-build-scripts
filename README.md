vyos-ami-build-scripts
======================

Scripts here are to automate the process of creating an AWS AMI from an VyOS ISO, using VirtualBox to install and pre-configure VyOS and then migrating the image to AWS.

The process is something like:

1. Download the VyOS ISO
2. Create a VirtualBox VM (`create-vyos-vbox-vm`) which includes the following:
 * Install VyOS on the VM, driving input via the serial console (`vyos-install.expect`)
 * Reboot and configure the VM, again via serial console (`vyos-configure.expect`)
3. Upload the disk image to AWS
4. Make an AMI out of the disk image, using PV-GRUB as the kernel (`volume-to-ami`)
 * Spin up an instance to see if it worked

# Status

I've written scripts for all of the VirtualBox automation, but not yet for the AWS portion (although I have notes of how to do it by hand.)

# Platform Requirements

I'm testing this on OSX and Windows/Cygwin, so I suspect it'll work on both and Linux too.

You'll need VirtualBox installed, VBoxManage in your PATH, `expect` and `socat` installed, and the ec2 CLI tools installed & working.

# Rationale

I'm sure this can be done better by submiting changes to the vyos iso build module and building an AMI directly from that.  Why this?  I did it because it was fun!
