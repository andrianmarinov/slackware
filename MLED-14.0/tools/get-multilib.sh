#!/bin/sh
#
# Retrieve multilib packages for Slackware64 14.0

SERVER="http://connie.slackware.com"
DIRECTORY="~alien/multilib"
VERSION="14.0"

/usr/bin/wget \
  -c \
  -r \
  -np \
  -nH \
  --cut-dirs=2 \
  --reject "index.html*,*.lst,*.meta,*.asc,*.md5,*.txt,*.TXT,*.gz,*.bz2,GPG-KEY,*.log,README" \
  --exclude-directories="$DIRECTORY/$VERSION/debug" \
  --execute robots=off \
  $SERVER/$DIRECTORY/$VERSION/ -P ../multilib
