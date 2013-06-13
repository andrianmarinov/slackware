# Installing a bitmap font is considered deprecated; use a TTF font instead.
# We try to link to an installed TTF font at install time.
# Configure a default TrueType font to use for the OSD :
OSDFONTS="LiberationSans-Regular.ttf \
          Arialuni.ttf arial.ttf \
          DejaVuSans.ttf Vera.ttf"
if [ ! -f usr/share/mplayer/subfont.ttf ]; then
  for font in ${OSDFONTS}; do
    if [ -f .${XPREF}/lib${LIBDIRSUFFIX}/X11/fonts/TTF/\${font} ]; then
      ( cd usr/share/mplayer/
      ln -sf ${XPREF}/lib${LIBDIRSUFFIX}/X11/fonts/TTF/\${font} subfont.ttf
      )
      break
    fi
  done
fi

# Update the mime database:
if [ -x usr/bin/update-mime-database ]; then
  chroot . /usr/bin/update-mime-database usr/share/mime >/dev/null 2>&1
fi
