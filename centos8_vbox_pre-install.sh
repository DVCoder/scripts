# Script was derived from information provided by https://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/
#!/usr/bin/sh

if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

echo -e -n " Choose a step : "
echo -e -n " 1 - Update Kernel*"
echo -e -n " 2 - Mount, Install Required Packages, and Install VBox Additions"
read answer
echo "$answer"

while true
do
	case $answer in
	1) dnf update kernel*
		echo -e -n " OS needs to reboot"
		read -p "Press enter to reboot"
		reboot
		break;;
	2) echo -e -n "On VirtualBox click Devices > Install Guest Additions"
	   read -p "Press enter when you have completed"
	   # Mount 
		mkdir /media/VirtualBoxGuestAdditions
		mount -r /dev/cdrom /media/VirtualBoxGuestAdditions
		## CentOS 8 and Red Hat (RHEL) 8 ##
		dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
		## CentOS/RHEL 8/7/6/5 ##
		yum install gcc kernel-devel kernel-headers dkms make bzip2 perl
		## Current running kernel on Fedora 30/29/28/27/26/25/24/23, CentOS 8/7/6 and Red Hat (RHEL) 8/7/6 ##
		KERN_DIR=/usr/src/kernels/`uname -r`
		export KERN_DIR
		cd /media/VirtualBoxGuestAdditions
		# Then run following command
		./VBoxLinuxAdditions.run
		read -p "Installation completed !!! Press enter to reboot"
		reboot
		break;;
	esac
done
