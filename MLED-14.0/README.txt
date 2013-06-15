=============================
Microlinux Enterprise Desktop (c) Niki Kovacs, <info@microlinux.fr>
=============================

This repository contains a complete collection of extra software for the
Slackware-based Microlinux Enterprise Desktop (MLED).


Introduction
------------

The Microlinux Enterprise Desktop is a full-blown production desktop based on
the latest stable Slackware Linux release and Xfce. It is currently used by
various small town halls, public libraries and schools in South France. 

MLED is *not* some derivative distribution. It consists of a collection of
currently 138 custom packages installed on top of an unaltered Slackware base
system. It focuses on the Xfce desktop environment, with many enhancements. 

A selection of carefully integrated applications are featured, one per task.
Elegant and sober artwork fit for use in a corporate environment is also
included. A complete selection of codecs, plugins and fonts provide a seamless
desktop experience. Intuitive and user-friendly default settings and menu
entries are provided. 

The Microlinux Enterprise Desktop runs reasonably fast on ten-year-old
hardware. A battered first-generation Pentium-IV with 512 MB RAM and a 10 GB
hard disk will be perfectly sufficient for the job.


Installation
------------

The following step-by-step instructions assume you already know how to install
a vanilla Slackware desktop. You will need a working internet connection.

The Microlinux Enterprise Desktop installs on top of a carefully selected
Slackware base. In order to avoid painstakingly picking each package, the
recommended method is to use the provided set of tagfiles. 

Boot the Slackware installation DVD (or the first CD). Select your keyboard
layout, login as root and partition your hard disk, but don't start the
installer yet.

Bring up your network interface, for example:

  root@slackware:/# dhcpcd eth0

The Slackware installation environment already sports an empty '/tag' directory
for a set of tagfiles, so let's use it.

  root@slackware:/# cd /tag

Grab the set of tagfiles from the server:

  root@slackware:/tag# wget http://www.microlinux.fr/slackware/MLED-14.0/tagfiles.tar.gz

Unpack the downloaded archive:

  root@slackware:/tag# tar xvzf tagfiles.tar.gz

Your '/tag' directory should now contain a series of directories corresponding
to the Slackware package sets:

  root@slackware:/tag# ls
  a/ ap/ d/ e/ f/ k/ kde/ kdei/ l/ n/ t/ tcl/ x/ xap/ xfce/ y/

Now start the Slackware installer:

  root@slackware:/tag# setup
 
PACKAGE SERIES SELECTION: accept the default package selection, since the
tagfiles will override this and take care of selecting each package anyway.

SELECT PROMPTING MODE: 'tagpath - Use tagfiles in the subdirectories of a
custom path'

Path to tagfiles: '/tag'

USE UTF-8 TEXT CONSOLE: 'Yes'

CONFIRM STARTUP SERVICES TO RUN: accept the default selection

SELECT DEFAULT WINDOW MANAGER FOR X : 'xinitrc.xfce' 

  -> This choice is of no consequence, since user profiles already contain the
  relevant '~/.xinitrc' file.

Finish the base Slackware installation and reboot.


Download the Microlinux scripts
-------------------------------

I'm providing a few helper scripts that will speed up the installation process.
Grab the whole Microlinux file tree using the following command. It's really
just a bunch of scripts and text files, so the download goes quite fast:

  # cd
  # git clone https://github.com/kikinovak/slackware


Configure 'slackpkg'
--------------------

Edit '/etc/slackpkg/mirrors' and choose one and only one mirror according to
your geographical location, for example:

--8<---------- /etc/slackpkg/mirrors -----------------------------------------
...
# FRANCE (FR)
ftp://mirror.ovh.net/mirrors/ftp.slackware.com/slackware64-14.0/
...
--8<--------------------------------------------------------------------------

Now blacklist all packages tagged "microlinux" to prevent them from getting
squashed by an update:

--8<---------- /etc/slackpkg/blacklist ---------------------------------------
...
[0-9]+_microlinux
--8<--------------------------------------------------------------------------

On Slackware64, you'll also have to blacklist Eric's Multilib packages:

--8<---------- /etc/slackpkg/blacklist ---------------------------------------
...
[0-9]+_microlinux
[0-9]+alien
--8<--------------------------------------------------------------------------

Now update everything:

  # slackpkg update
  # slackpkg upgrade-all


Trim the installation 
---------------------

In case you didn't use the set of tagfiles during the initial installation,
now's the time to eventually catch up on it. The 'tools' directory provides a
basic 'trim-desktop-base.sh' script that takes care of two things:

  1. install needed packages
  2. get rid of unneeded packages

The script makes use of 'slackpkg', so make sure it's configured for use.

  # cd slackware/MLED-14.0/tools/
  # ./trim-desktop-base.sh

If you don't use the script, then you still have to install the MPlayer plugin
from 'extra/' manually:

  # slackpkg install mplayerplug-in


Download the MLED package collection
------------------------------------

The MLED package collection can be downloaded here:

  * http://www.microlinux.fr/slackware/MLED-14.0/

Packages for 32-bit Slackware are in the 'pkg' subdirectory, packages for
Slackware64 can be found in 'pkg64'. Of course, you're free to use wget, curl,
lynx or links or whatever tool you prefer to grab all the packages. The easiest
way will be to use the automated download script:

  # cd tools
  # ./get-MLED.sh

There are roughly 500 megabytes of packages, so you'll have to wait a moment
depending on your bandwidth. Once the download is finished, change into the
package directory:

  # cd ../pkg

On Slackware64:

  # cd ../pkg64

Install the whole package collection using the following command:

  # upgradepkg --reinstall --install-new *.txz


Set locales
-----------

Now you'll probably have to adjust your environment variables in
'/etc/profile.d/lang.sh'. Default variables are set to fr_FR.UTF8, since MLED's
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

On Slackware64, you may want to add applications like VirtualBox.  In that
case, you have to install the 32-bit compatibility layer provided by Eric
Hameleers. I'm providing a little script in the 'tools' directory that takes
care of downloading all necessary Multilib packages : 
  
  # cd tools/
  # get-multilib.sh

Once all packages are downloaded, change into the 'multilib' directory and
install everything:

  # cd ../multilib/14.0/
  # upgradepkg --reinstall --install-new *.t?z
  # cd slackware64-compat32/
  # upgradepkg --install-new *-compat32/*.t?z


A word about NVidia cards
-------------------------

I've had some bad freezes with the 'nouveau' drivers on various cards, so I
decided not to include these - as well as the legacy 'nv' drivers - in the
basic package set. I recommend downloading and building the proprietary
'nvidia' drivers from http://www.nvidia.com. 

If you don't want to use the 'nvidia' driver, you can still grab the
'xf86-video-nouveau' or 'xf86-video-nv' packages manually.

That being said, don't install the proprietary 'nvidia' driver yet. Its
presence will lead to build errors for some packages like wxGTK, Firefox ESR
and Thunderbird ESR.

Eventually, you can always uninstall it like this:

  # ./NVIDIA-Linux-x86-XXX.YY.run --uninstall
 
In that case, reinstall the 'mesa' package.


Java Development Kit
--------------------

Before launching the build, go to 'http://www.oracle.com' and download the JDK
tarball for your architecture:

  * jdk-7uXX-linux-i586.tar.gz for 32-bit Slackware
  * jdk-7uXX-linux-x64.tar.gz for 64-bit Slackware

Move the tarball to source/d/jdk/.


Start the build
---------------

  # ./MLED.SlackBuild

This master build takes care of: 

  1. downloading all sources;

  2. building packages in the right order;

  3. installing packages as they are built;

  4. storing them in the right location, depending on your architecture.

  /!\ Some applications like Firefox ESR and Thunderbird ESR can take ages to
  build on old hardware. Whenever possible, complete the whole build on a fast
  machine and then install the resulting binaries on your less performing
  hardware.


Clean up the applications menu
------------------------------

The 'tools/' directory features - among other things - the 'cleanmenu' utility,
a small Bash script to clean up various desktop menu entries and make them
Joe-Sixpack-friendly. Run this utility:

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

Reboot and enjoy your shiny new Microlinux Enterprise Desktop.

                                    Niki Kovacs, Tue May  7 18:22:13 CEST 2013

------------------------------------------------------------------------------
# vim: syntax=txt

