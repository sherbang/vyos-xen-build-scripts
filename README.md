vyos-ami-build-scripts
======================

Scripts here are to automate the process of creating an AWS AMI from an VyOS ISO, using VirtualBox to install and pre-configure VyOS and then migrating the image to AWS.

The process is something like:

1. Download the VyOS ISO
2. Create a VirtualBox VM (`create-vyos-vbox-vm`) which includes the following:
 * Install VyOS on the VM, driving input via the serial console (`vyos-install.expect`)
 * Reboot and configure the VM, again via serial console (`vyos-configure.expect`)
 * Reboot again from the VyOS ISO with a second disk attached, and duplicate the partition data into it's own volume (`copy-partition-to-disk.expect`)
3. Upload the disk image to AWS (`push-image-to-aws`)
 * Make an AMI out of the disk image, using PV-GRUB as the kernel (`volume-to-ami`)
   * Spin up an instance to see if it worked

# Status

Under heavy development.  Most of the code is here, but needs a lot of refinement.  The VirtualBox automation works beautifully on my OS X machine and my Windows/Cygwin machine.  The AWS scripts will work for me only as I haven't automated the S3 portion just yet.

The produced AMI boots and works.  It loads the specified public key for SSH authentication, so you must authenticate as user vyos with your key.  However you can modify this after initial login.

## AMI IDs for public use

These images are provided AS-IS and are not official VyOS releases. Please don't file bugs to the VyOS team, just file them to this project on github.  These images are not widely used nor have been vetted by any other developers.

Version "VyOS 1.0.2 Preview AMI 20140224pv":
* ap-northeast-1  - `ami-f97c0bf8`
* ap-southeast-1 - `ami-a45405f6`
* ap-southeast-2  - `ami-abe77e91`
* eu-west-1  - `ami-a000f3d7`
* sa-east-1  - `ami-69bc1f74`
* us-east-1  - `ami-6763630e`
* us-west-1  - `ami-2cdde169`
* us-west-2  - `ami-4e204c7e`

## To Do

* Automate S3 bucket creation
* Get it working reliably building nightly VyOS images
* Explore integrating with https://github.com/vyos/build-iso
 * Add an option in the installer like `install image xen-pv` or maybe `install image pvgrub` which installs a `menu.lst` file appropriate for PV-GRUB 0.97, and puts in the right upgrade hooks so that this file is kept up to date.
* Write test script to verify that VirtualBox VBoxManage, expect, socat, ec2-* tools all will work as expected, which gets run before we try anything.  Need to test that ec2 permissions are working.
* Automate cleanup of the mess this leaves behind - a dangling s3 directory and a dangling EBS volume. Or perhaps the AMI can be registered directly from the s3 bucket, rather than a snapshot?  But maybe we don't want this.
* Script to duplicate the AMI to all regions and make them publicly usable
* Work with VyOS maintainers to publish these AMIs to the AWS Marketplace under the VyOS name, like what CentOS has done.

# Platform Requirements

I'm testing this on OSX and Windows/Cygwin, so I suspect it'll work on both and Linux too.

You'll need VirtualBox installed, VBoxManage in your PATH, `expect` and `socat` installed, and the ec2 CLI tools installed & working.

# Rationale

I'm sure this can be done better by submiting changes to the vyos iso build module and building an AMI directly from that.  Why this?  I did it because it was fun!

# Credits

Thanks to j3tm0t0 who wrote the first guide I ever found on how to set up Vyatta Core 6.3 in AWS.  I've now used some of these ideas to get this up and going, and we've also used this guide at work (mintel.com) to build a private Vyatta Core image which we've reused many times.  Whoever you are good sir, thank you!  Link: http://d.hatena.ne.jp/j3tm0t0/20111113/1321192227
