#!/bin/sh
#
# Copyright (c) 2013 Niki Kovacs <info@microlinux.fr>
# -----------------------------------------------------------------------------
#
# This script parses the build_order file in the parent directory and installs
# all listed packages using slackpkg. 
#
# The slackpkg+ plugin has to be installed and the MLED repository configured.
#

CWD=$(pwd)

INSTALL=$(egrep -v '(^\#)|(^\s+$)' $CWD/../build_order)

unset PACKAGES

for PACKAGE in $INSTALL; do
  if [ ! -r /var/log/packages/${PACKAGE}-[r,0-9]* ] ; then
    PACKAGES="$PACKAGES $PACKAGE"
  fi
done

if [ -z "$PACKAGES" ]; then
  continue
else
  /usr/sbin/slackpkg install $PACKAGES
fi

echo
echo ":: Microlinux Enterprise Desktop installed."
echo
