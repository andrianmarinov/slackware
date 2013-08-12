#!/bin/sh
#
# copy-tagfiles.sh
#
# (c) Daniel de Kok, http://www.slackbasics.org
# 
# Modified by Niki Kovacs <info@microlinux.fr>
#
# The official Slackware Linux distribution contains a tagfile in the
# directory for each disk set. These tagfiles can be used as a start.
# The present script can be used to copy the tagfiles to the current
# directory, preserving the disk set structure. 
#
# This script also creates a file PACKAGE_DESCRIPTIONS in each package
# set subdirectory, since even the most hard-boiled geeks don't always
# know every item by heart in all that *NIX alphabet soup ;o) 
#
# Simply mount a Slackware CD, change into the target directory where
# you want to store your tagfile sets, and then:
# 
# $ sh /path/to/copy-tagfiles.sh /mnt/cdrom/slackware
#
# Repeat operation for all disks.
#
# CAUTION! Beware of trailing slashes (NOT "/mnt/cdrom/slackware/")


if [ ! $# -eq 1 ] ; then
	echo "Syntax: $0 [directory]"
	exit
fi

for i in $1/*/ ; do
	setdir=`echo $i | egrep -o '\w+/$' | xargs basename`
	echo "   === Package group [$setdir] ===   "
	echo
	echo ":: Creating directory."
	mkdir $setdir
	echo ":: Copying tagfile."
	cp $i/tagfile $setdir
	echo ":: Making package description file."
	cat $i/*.txt > $setdir/PACKAGE_DESCRIPTIONS.txt
	echo
done

