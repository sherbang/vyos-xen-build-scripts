vyos-xen-build-scripts
======================

Scripts here are to automate the process of creating an Xen open source (not XenServer) image from an VyOS ISO, using VirtualBox to install and pre-configure VyOS.

The process is something like:

1. Download the VyOS ISO
2. Create a VirtualBox VM (`create-vyos-vbox-vm`) which includes the following:
 * Install VyOS on the VM, driving input via the serial console (`vyos-install.expect`)
 * Reboot and configure the VM, again via serial console (`vyos-configure.expect`)
 * Reboot again from the VyOS ISO with a second disk attached, and duplicate the partition data into it's own volume (`copy-partition-to-disk.expect`)
3. Copy the .vhd file and vyos.cfg to your Xen server.
4. Convert the .vhd file to your disk partition:
 * sudo qemu-img convert -f vpc vyos-ami-build-20150331-170656.vhd -O raw /dev/vg0/vyos
5. Modify vyos.cfg as-needed for your environment
6. sudo xm create -c vyos.cfg
 * This will show you pygrub, after that you'll need to use vncviewer to see the console.

SSH and DHCP are enabled on the first interface, so you can do the rest of the config that way.

# Status

Works for me.  Send me pull requests if it doesn't work for you.

# Platform Requirements

I'm testing this on Linux, but will accept pull requests for fixes on other platforms if they don't break it for me.

You'll need VirtualBox installed, VBoxManage in your PATH, `expect` and `socat` installed, and the ec2 CLI tools installed & working.

# Credits

This was forked from https://github.com/trickv/vyos-ami-build-scripts which builds images to uploade to AWS.  I mostly just ripped out the Amazon specific parts, and worked out the right setup for vyos.cfg.
