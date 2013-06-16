#!/bin/sh
SCP=$(which scp)
CWD=$(pwd)
LOCALDIR=$CWD/../..
SCPUSER=kikinovak
SERVER=nestor
SERVERDIR=/srv/httpd/vhosts/mirror/htdocs/microlinux
$SCP -r $LOCALDIR/* $SCPUSER@$SERVER:$SERVERDIR/

