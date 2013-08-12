#!/bin/sh
#
# Create masquerade symlinks for distcc
#
# Written for Slackware Linux by Erik Jan Tromp
# 
# Modified by Niki Kovacs <info@microlinux.fr>

# Compilers for C and C++ (without path)
COMPILERS="gcc-4.7.1 g++-gcc-4.7.1"

# Masquerade directory
MASQUERADE_DIRECTORY=/usr/lib/distcc/bin

# Distcc path
DISTCC=../../../bin/distcc

# Clear directory
rm -rf $MASQUERADE_DIRECTORY
mkdir -p $MASQUERADE_DIRECTORY

# Weed out bogus compiler entries
COMPILERS=`which $COMPILERS 2> /dev/null`

# Find all links
LINKS=""
for COMPILER in $COMPILERS ; do
  COMPILER_DIRECTORY=`dirname $COMPILER`
  COMPILER_FILE=`basename $COMPILER`
  INODE=`find $COMPILER_DIRECTORY -name $COMPILER_FILE -follow -printf %i 2> /dev/null`
  LINKS=$LINKS`find $COMPILER_DIRECTORY -inum $INODE -follow -printf "%f " 2> /dev/null`
done

# Create all links
for LINK in $LINKS ; do
  echo $LINK
  ln -s $DISTCC $MASQUERADE_DIRECTORY/$LINK
done
