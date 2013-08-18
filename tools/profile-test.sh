#!/bin/bash
#
# profile-test.sh
if (grep test /etc/passwd); then
  userdel -r test
fi

useradd -c "Test User" \
  -m \
  -d /home/test \
  -g users \
  -G audio,video,cdrom,lp,floppy,plugdev,power,netdev,scanner \
  -s /bin/bash \
    test

echo "test:test" | chpasswd

