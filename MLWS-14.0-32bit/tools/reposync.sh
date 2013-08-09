#!/bin/sh
RSYNC=$(which rsync)
CWD=$(pwd)
LOCALSTUFF=$CWD/../..
EXCLUDEFILE=$CWD/reposync_exclude
RSYNCUSER=kikinovak
SERVER=nestor
SERVERDIR=/srv/httpd/vhosts/mirror/htdocs/microlinux
$RSYNC -av $LOCALSTUFF --exclude-from $EXCLUDEFILE $RSYNCUSER@$SERVER:$SERVERDIR 

