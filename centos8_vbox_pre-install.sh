# Script was derived from information provided by https://www.if-not-true-then-false.com/2010/install-virtualbox-guest-additions-on-fedora-centos-red-hat-rhel/
#!/usr/bin/sh
set -e 
if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

echo -e -n " Which step are you on? (***OS will reboot automatically after each step***)\n\r"
echo -e -n " 1 - Update Kernel*\n\r"
echo -e -n " 2 - Mount, Install Required Packages, and Install VBox Additions\n\r"
echo -e -n " Select step 1 or 2: "
read answer

while true
do
	case $answer in
	1)	echo -e -n " Updating kernel* \r\n"
		dnf update kernel* -y
		reboot
		break;;
	2) 
		read -p "On VirtualBox click Devices > Insert Guest Additions CD Image. Press ENTER when you have completed ..."
	   	# Mount 
		mkdir /media/VirtualBoxGuestAdditions
		mount -r /dev/cdrom /media/VirtualBoxGuestAdditions
		## CentOS 8 and Red Hat (RHEL) 8 ##
		dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
		## CentOS/RHEL 8/7/6/5 ##
		yum install gcc kernel-devel kernel-headers dkms make bzip2 perl -y
		## Current running kernel on Fedora 30/29/28/27/26/25/24/23, CentOS 8/7/6 and Red Hat (RHEL) 8/7/6 ##
		KERN_DIR=/usr/src/kernels/`uname -r`
		export KERN_DIR
		cd /media/VirtualBoxGuestAdditions
		# Then run following command
		./VBoxLinuxAdditions.run
		reboot
		break;;
	esac
done
