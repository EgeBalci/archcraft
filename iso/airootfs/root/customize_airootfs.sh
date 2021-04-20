#!/usr/bin/env bash
#
# SPDX-License-Identifier: GPL-3.0-or-later

set -e -u

# Warning: customize_airootfs.sh is deprecated! Support for it will be removed in a future archiso version.

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist

## Add liveuser to these groups
#usermod -G "adm,audio,video,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" liveuser

## Disto Info
cat > "/etc/os-release" <<- EOL
	NAME="GenOS"
	PRETTY_NAME="GenOS"
	ID=arch
	BUILD_ID=rolling
	ANSI_COLOR="38;2;23;147;209"
	HOME_URL="https://github.io/egebalci/genos"
	LOGO=genos
EOL

cat > "/etc/issue" <<- EOL
	GenOS \r (\l)
EOL

## Append genos repository to pacman.conf
cat >> "/etc/pacman.conf" <<- EOL

[multilib]
Include = /etc/pacman.d/mirrorlist
EOL

## Hide Unnecessary Apps
adir="/usr/share/applications"
apps=(avahi-discover.desktop bssh.desktop bvnc.desktop compton.desktop echomixer.desktop \
envy24control.desktop exo-mail-reader.desktop exo-preferred-applications.desktop feh.desktop gparted.desktop \
hdajackretask.desktop hdspconf.desktop hdspmixer.desktop hwmixvolume.desktop lftp.desktop \
libfm-pref-apps.desktop lxshortcut.desktop lstopo.desktop mimeinfo.cache \
networkmanager_dmenu.desktop nm-connection-editor.desktop pcmanfm-desktop-pref.desktop \
qv4l2.desktop qvidcap.desktop stoken-gui.desktop stoken-gui-small.desktop thunar-bulk-rename.desktop \
thunar-settings.desktop thunar-volman-settings.desktop yad-icon-browser.desktop)

for app in "${apps[@]}"; do
	if [[ -f "$adir/$app" ]]; then
		sed -i '$s/$/\nNoDisplay=true/' "$adir/$app"
	fi
done

## Other Stuff
cp /usr/bin/networkmanager_dmenu /usr/local/bin/nmd && sed -i 's/config.ini/nmd.ini/g' /usr/local/bin/nmd
sed -i -e 's/Inherits=.*/Inherits=Hybrid_Light,Papirus,Moka,Adwaita,hicolor/g' /usr/share/icons/Arc/index.theme
rm -rf /usr/share/xsessions/openbox-kde.desktop /usr/share/applications/xfce4-about.desktop /usr/share/pixmaps/genos.png /usr/share/pixmaps/genos.svg
