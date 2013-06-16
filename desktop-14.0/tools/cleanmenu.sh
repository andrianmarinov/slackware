#!/bin/bash
#
# cleanmenu.sh
# (c) Niki Kovacs, 2008

CWD=$(pwd)
ENTRIESDIR=$CWD/desktop_entries
ENTRIES=`ls $ENTRIESDIR` 
MENUDIRS="  /usr/share/applications \
				    /usr/share/gdm/applications \
            /usr/share/distcc \
						/opt/openoffice.org3/share/xdg"

for MENUDIR in $MENUDIRS; do
	for ENTRY in $ENTRIES; do
		if [ -r $MENUDIR/$ENTRY ]; then
			echo ":: Updating $ENTRY."
			cat $ENTRIESDIR/$ENTRY > $MENUDIR/$ENTRY
		fi
	done
done

