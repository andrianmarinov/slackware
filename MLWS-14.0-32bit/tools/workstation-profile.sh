#!/bin/bash
#
# workstation-profile.sh
# (c) Niki Kovacs, 2013

CWD=$(pwd)
cat $CWD/kde/custom/00-defaultLayout.js > \
  /usr/share/apps/plasma-desktop/init/00-defaultLayout.js 

cat $CWD/kde/custom/layout.js > \
  /usr/share/apps/plasma/layout-templates/org.kde.plasma-desktop.defaultPanel/contents/layout.js


