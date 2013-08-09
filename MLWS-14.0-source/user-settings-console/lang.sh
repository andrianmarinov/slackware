#!/bin/sh
# Set the system locale.  (no, we don't have a menu for this ;-)
# For a list of locales which are supported by this machine, type:
#   locale -a

# en_US is the Slackware default locale:
# export LANG=en_US

# 'C' is the old Slackware (and UNIX) default, which is 127-bit
# ASCII with a charmap setting of ANSI_X3.4-1968.  These days,
# it's better to use en_US or another modern $LANG setting to
# support extended character sets.
#export LANG=C

# There is also support for UTF-8 locales, but be aware that
# some programs are not yet able to handle UTF-8 and will fail to
# run properly.  In those cases, you can set LANG=C before
# starting them.  Still, I'd avoid UTF unless you actually need it.
# export LANG=en_US.UTF-8

# Another option for en_US:
#export LANG=en_US.ISO8859-1

# One side effect of the newer locales is that the sort order
# is no longer according to ASCII values, so the sort order will
# change in many places.  Since this isn't usually expected and
# can break scripts, we'll stick with traditional ASCII sorting.
# If you'd prefer the sort algorithm that goes with your $LANG
# setting, comment this out.
# export LC_COLLATE=C

#########################
# Slackware en français #
#########################

# Pour franciser le système, commenter la ligne LANG ci-dessus et décommenter
# la ligne LANG ci-dessous. Ensuite, définir la police de caractères 'lat9w-16'
# dans '/etc/rc.d/rc.font'.  Pour définir un clavier français dans la console,
# éditer '/etc/rc.d/rc.keymap' ainsi que '/etc/mkinitrd.conf', sans oublier
# d'invoquer 'mkinitrd -F' et 'lilo' juste après. 
export LANG=fr_FR.utf8
export LC_COLLATE=fr_FR.utf8

#########################
# Slackware auf Deutsch # 
#########################

# Um das System auf Deutsch umzustellen, muss die obige LANG-Zeile kommentiert
# und die untenstehende LANG-Zeile auskommentiert werden. Weiters muss die
# Konsolenschriftart 'lat9w-16' in '/etc/rc.d/rc.font' definiert werden. Die
# Tastaturbelegung wird nicht nur in '/etc/rc.d/rc.keymap' festgelegt, sondern
# auch in '/etc/mkinitrd.conf'. Nicht vergessen, danach 'mkinitrd -F' und
# 'lilo' aufzurufen.
# export LANG=de_DE.utf8
# export LC_COLLATE=de_DE.utf8

# End of /etc/profile.d/lang.sh

