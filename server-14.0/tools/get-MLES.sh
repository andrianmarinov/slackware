#!/bin/sh
#
# Retrieve Microlinux Enterprise Server packages 

SERVER="http://www.microlinux.fr"
DIRECTORY="slackware"
VERSION="14.0"
CWD=$(pwd)

case $(uname -m) in 
  x86_64) TXZDIR=pkg64 ;;
  *     ) TXZDIR=pkg ;;
esac  

/usr/bin/wget \
-c \
-r \
-np \
-nH \
--cut-dirs=3 \
--reject "index.html*" \
$SERVER/$DIRECTORY/MLES-$VERSION/$TXZDIR/ -P ../$TXZDIR

echo
echo ":: All packages downloaded to the $TXZDIR directory. Change into it and"
echo ":: install everything using the following command:"
echo "::"
echo "::   # upgradepkg --reinstall --install-new *.txz"
echo "::"
echo 
