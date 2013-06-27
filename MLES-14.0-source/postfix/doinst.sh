#!/bin/sh

config() {
  NEW="$1"
  OLD="$(dirname $NEW)/$(basename $NEW .new)"
  # If there's no config file by that name, mv it over:
  if [ ! -r $OLD ]; then
    mv $NEW $OLD
  elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
    rm $NEW
  fi
  # Otherwise, we leave the .new copy for the admin to consider...
}

config etc/postfix/access.new
config etc/postfix/aliases.new
config etc/postfix/canonical.new
config etc/postfix/generic.new
config etc/postfix/header_checks.new
config etc/postfix/main.cf.default.new
config etc/postfix/main.cf.new
config etc/postfix/makedefs.out.new
config etc/postfix/master.cf.new
config etc/postfix/relocated.new
config etc/postfix/transport.new
config etc/postfix/virtual.new
config etc/rc.d/rc.postfix.new

# This is an incompatability with the sendmail package
( cd usr/lib; rm -f sendmail )
( cd usr/lib; ln -s /usr/sbin/sendmail sendmail)

# This will set the permissions on all postfix files correctly
postfix set-permissions

# Symlinks added by makepkg(8)

# Create postfix group 
if ! grep -q "^postfix:" /etc/group ; then
groupadd -g 200 postfix
echo ":: Added postfix group."
sleep 3
fi

# Create postfix user 
if ! grep -q "^postfix:" /etc/passwd ; then
useradd -u 200 -d /dev/null -s /bin/false -g postfix postfix
echo ":: Added postfix user."
sleep 3
fi

# Create postdrop group 
if ! grep -q "^postdrop:" /etc/group ; then
groupadd -g 201 postdrop
echo ":: Added postdrop group."
sleep 3
fi
