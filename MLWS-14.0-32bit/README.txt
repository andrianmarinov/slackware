=================================
Microlinux Enterprise Workstation (c) Niki Kovacs, <info@microlinux.fr>
=================================

This repository contains a complete collection of extra software for the
Slackware-based Microlinux Enterprise Workstation (MLWS).


  * Introduction
  * Installation
  * Download the Microlinux scripts
  * Configure 'slackpkg'
  * Trim and upgrade
  * Install the MLWS package collection
  * Set locales
  * Multilib stuff 
  * Clean up the applications menu
  * Finishing up


Introduction
------------

The Microlinux Enterprise Workstation is a full-blown production desktop based
on the latest stable Slackware Linux and a trimmed-down KDE desktop.  

MLWS is *not* some derivative distribution. It consists of a collection of
roughly 150 custom packages installed on top of an unaltered Slackware base
system. It focuses on the KDE desktop environment, trimmed down and with many
enhancements. 

A selection of carefully integrated applications are featured, one per task.
Elegant and sober artwork fit for use in a corporate environment is also
included. A complete selection of codecs, plugins and fonts provide a seamless
desktop experience. Intuitive and user-friendly default settings and menu
entries are provided. 

The Microlinux Enterprise Workstation runs reasonably fast on ten-year-old
hardware. A battered first-generation Pentium-IV with 512 MB RAM and a 10 GB
hard disk will be perfectly sufficient for the job, though 1 GB of RAM will get
you a more decent desktop experience.


Installation
------------

The following step-by-step instructions assume you already know how to install
a vanilla Slackware desktop. You will need a working internet connection.

The Microlinux Enterprise Workstation installs on top of a carefully selected
Slackware base. In order to avoid painstakingly picking each package, the
recommended method is to use the provided set of tagfiles. 

Boot the Slackware installation DVD (or the first CD). Select your keyboard
layout, login as root and partition your hard disk, but don't start the
installer yet.

Bring up your network interface, for example:

  root@slackware:/# dhcpcd eth0

The Slackware installation environment already sports an empty '/tag' directory
for a set of tagfiles, so let's use it.

  # cd /tag

Grab the set of tagfiles from the server:

  # wget http://www.microlinux.fr/slackware/MLWS-14.0-32bit/tagfiles.tar.gz

  /!\ The sets of tagfiles in the 32-bit and 64-bit subdirectories are
  symlinked and thus identical. 

Unpack the downloaded archive:

  # tar xvzf tagfiles.tar.gz

Your '/tag' directory should now contain a series of directories corresponding
to the Slackware package sets:

  # ls
  a/ ap/ d/ e/ f/ k/ kde/ kdei/ l/ n/ t/ tcl/ x/ xap/ xfce/ y/

Now start the Slackware installer:

  # setup
 
PACKAGE SERIES SELECTION: accept the default package selection, since the
tagfiles will override this and take care of selecting each package anyway.

SELECT PROMPTING MODE: 'tagpath - Use tagfiles in the subdirectories of a
custom path'

Path to tagfiles: '/tag'

USE UTF-8 TEXT CONSOLE: 'Yes'

CONFIRM STARTUP SERVICES TO RUN: accept the default selection

SELECT DEFAULT WINDOW MANAGER FOR X : 'xinitrc.kde' 

  -> This choice is of no consequence, since user profiles already contain the
  relevant '~/.xinitrc' file.

Finish the base Slackware installation and reboot.


Download the Microlinux scripts
-------------------------------

I'm providing a few helper scripts that will speed up the installation process.
Grab the whole Microlinux file tree using the following command:

  # cd
  # git clone https://github.com/kikinovak/slackware


Configure 'slackpkg'
--------------------

Download the 'slackpkg+' plugin for 'slackpkg'. It's very convenient for
handling third-party repositories like MLWS:

  # links http://slakfinder.org/slackpkg+

Grab the package from the 'pkg/' directory and install it.

Edit '/etc/slackpkg/mirrors' and choose a Slackware mirror according to your
geographical location, for example:

--8<---------- /etc/slackpkg/mirrors -----------------------------------------
...
# FRANCE (FR)
ftp://mirror.ovh.net/mirrors/ftp.slackware.com/slackware64-14.0/
...
--8<--------------------------------------------------------------------------

  /!\ Make sure you choose only one single mirror for Slackware stable.

Configure 'slackpkg+':

  # cd /etc/slackpkg
  # mv slackpkgplus.conf slackpkgplus.conf.orig

On 32-bit Slackware:

--8<---------- /etc/slackpkg/slackpkgplus.conf -------------------------------
# /etc/slackpkg/slackpkgplus.conf
SLACKPKGPLUS=on
PKGS_PRIORITY=( microlinux:.* )
REPOPLUS=( slackpkgplus microlinux )
MIRRORPLUS['microlinux']=http://www.microlinux.fr/slackware/MLWS-14.0-32bit/
MIRRORPLUS['slackpkgplus']=http://slakfinder.org/slackpkg+/
--8<--------------------------------------------------------------------------

On Slackware64:

--8<---------- /etc/slackpkg/slackpkgplus.conf -------------------------------
# /etc/slackpkg/slackpkgplus.conf
SLACKPKGPLUS=on
PKGS_PRIORITY=( microlinux:.* )
REPOPLUS=( slackpkgplus microlinux )
MIRRORPLUS['microlinux']=http://www.microlinux.fr/slackware/MLWS-14.0-64bit/
MIRRORPLUS['slackpkgplus']=http://slakfinder.org/slackpkg+/
--8<--------------------------------------------------------------------------

Update GPG keys :

  # slackpkg update gpg

Update information about available packages:

  # slackpkg update


Trim and upgrade
----------------

In case you didn't use the set of tagfiles during the initial installation,
now's the time to eventually catch up on it. The 'tools' directory provides a
basic 'trim-desktop-base.sh' script that takes care of two things:

  1. install needed packages
  2. get rid of unneeded packages

The script makes use of 'slackpkg', so make sure it's configured correctly.

  # cd slackware/MLWS-14.0-32bit/tools/
  # ./trim-workstation-base.sh

  /!\ You may use this script in Slackware64. The script in the 64-bit file
  tree is only a symlink to the script above.

If you don't use the 'trim-desktop-base.sh' script, then you still have to
install the MPlayer plugin from 'extra/' manually:

  # slackpkg install mplayerplug-in

Now upgrade the base Slackware packages:

  # slackpkg upgrade-all


Install the MLWS package collection
-----------------------------------

Simply use the provided 'install-MLWS.sh' script in the 'tools/' directory:

  # cd tools/
  # ./install-MLWS.sh

This script parses the 'packages-MLWS' file in the 'pkglists' directory and
takes care of downloading and installing all listed packages using 'slackpkg'.

  /!\ From time to time, there's some new stuff added to MLWS. If you want to
  integrate the Full Monty of new packages, it's as simple as re-running the
  'install-MLWS.sh' script. It will automagically take care of everything.


Set locales
-----------

Now you'll probably have to adjust your environment variables in
'/etc/profile.d/lang.sh'. Default variables are set to fr_FR.UTF8, since MLWS's
main use is in France:

--8<---------- /etc/profile.d/lang.sh ----------------------------------------
export LANG=fr_FR.utf8
export LC_COLLATE=fr_FR.utf8
--8<--------------------------------------------------------------------------

English-speaking Slackware users will use something like this:

--8<---------- /etc/profile.d/lang.sh ----------------------------------------
export LANG=en_US.utf8
export LC_COLLATE=en_US.utf8
--8<--------------------------------------------------------------------------


Multilib stuff 
--------------

On Slackware64, you may want to add applications like VirtualBox, Wine, Skype,
etc.  In that case, you have to install the 32-bit compatibility layer provided
by Eric Hameleers. The 'slackpkg+' plugin makes this task very easy. 

First, add the Multilib repository:

--8<---------- /etc/slackpkg/slackpkgplus.conf -------------------------------
...
REPOPLUS=( ... multilib )
MIRRORPLUS['multilib']=http://taper.alienbase.nl/mirrors/people/alien/multilib/14.0/
...
--8<--------------------------------------------------------------------------

The Multilib repository takes precedence over standard Slackware packages:

--8<---------- /etc/slackpkg/slackpkgplus.conf -------------------------------
...
PKGS_PRIORITY=( ... multilib:.* )
...
--8<--------------------------------------------------------------------------

Here's what our complete configuration file looks like now:

--8<---------- /etc/slackpkg/slackpkgplus.conf -------------------------------
# /etc/slackpkg/slackpkgplus.conf
SLACKPKGPLUS=on
PKGS_PRIORITY=( microlinux:.* multilib:.* )
REPOPLUS=( microlinux slackpkgplus )
MIRRORPLUS['microlinux']=http://mirror.nestor/microlinux/MLWS-14.0-64bit/
MIRRORPLUS['multilib']=http://taper.alienbase.nl/mirrors/people/alien/multilib/14.0/
MIRRORPLUS['slackpkgplus']=http://slakfinder.org/slackpkg+/
--8<--------------------------------------------------------------------------

Upgrade your system:

  # slackpkg upgrade-all

  /!\ This will replace all the stock gcc-* and glibc-* packages with Eric's
  multilib versions.

Now install the complete set of additional 32-bit support libraries. This can
be done in one simple step using the following command:

  # slackpkg install compat32


Clean up the applications menu
------------------------------

The 'tools/' directory features the 'cleanmenu' utility, a small Bash script to
clean up various desktop menu entries and make them Joe-Sixpack-friendly. Run
this utility:

  # cd tools/
  # ./cleanmenu

  /!\ The script replaces many '*.desktop' files in '/usr/share/applications'
  and similar locations by some custom-made menu entry files. For now, they're
  only localized in english, french and german, so you may not want to run the
  script if you use another language.


Finishing up
------------

We're almost there. Here's what's left to be done.

  1. Configure the X.org server. 

  2. Define one or more normal users for the system.

  3. Switch to default runlevel 4.

Reboot and enjoy your shiny new Microlinux Enterprise Workstation.


Using the NetworkManager
------------------------

MLWS doesn't make use of KDE's network management applet and relies instead on
GNOME's corresponding applet, which already ships with Slackware in the
'network-management-applet' package. In its default configuration, the applet
is not supposed to appear in a KDE session:

  $ grep KDE /etc/xdg/autostart/nm-applet.desktop 
  NotShowIn=KDE;

As root, clean up any remaining configuration in '/etc/rc.d/rc.inet1.conf':

--8<---------- /etc/rc.d/rc.inet1.conf ---------------------------------------
...
# Config information for eth0:
IPADDR[0]=""
NETMASK[0]=""
USE_DHCP[0]="yes"
DHCP_HOSTNAME[0]=""

# Config information for eth1:
IPADDR[1]=""
NETMASK[1]=""
USE_DHCP[1]=""
DHCP_HOSTNAME[1]=""
...
# Default gateway IP address:
GATEWAY=""
...
--8<--------------------------------------------------------------------------

Activate the NetworkManager:

  # chmod +x /etc/rc.d/rc.networkmanager

As a normal user, enable the corresponding applet:

  $ mkdir ~/.config/autostart
  $ grep -v NotShowIn /etc/xdg/autostart/nm-applet.desktop > \
      ~/.config/autostart/nm-applet.desktop

Reboot, and you're ready. Notice the applet makes use of Oxygen GTK and
integrates nicely.

  /!\ If you're dubious about this setup, I got the idea by looking at a Red
  Hat Enterprise Linux 6.x workstation running KDE. 


                                    Niki Kovacs, Fri Aug 23 06:26:42 CEST 2013

------------------------------------------------------------------------------
# vim: syntax=txt

