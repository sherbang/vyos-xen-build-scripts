vyos-ami-build-scripts
======================

Scripts here are to automate the process of creating an AWS AMI from an VyOS ISO, using VirtualBox to install and pre-configure VyOS and then migrating the image to AWS.

The process is something like:
* Download the VyOS ISO
* Create a VirtualBox VM
* Install VyOS on the VM, driving input via the serial console
* Reboot and configure the VM, again via serial console
* Upload the disk image to AWS
* Make an AMI out of the disk image, using PV-GRUB as the kernel
* Spin up an instance to see if it worked

= Status

I've written scripts for all of the VirtualBox automation, but not yet for the AWS portion (although I have notes of how to do it by hand.)

= Rationale

I'm sure this can be done better by submiting changes to the vyos iso build module and building an AMI directly from that.  Why this?  I did it because it was fun!
