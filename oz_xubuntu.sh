#!/bin/bash

sudo apt-get --purge autoremove thunderbird parole pidgin xfburn gnome-mines gnome-sudoku sgt-puzzles ristretto simple-scan blueman bluez*
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo add-apt-repository ppa:papirus/papirus -y
sudo add-apt-repository ppa:snwh/ppa -y
#
sudo apt update -y
sudo apt install --install-recommends winehq-devel -y
sudo apt install libreoffice-style-papirus -y
sudo apt install mpv rhythmbox paper-icon-theme arc-theme gimp shotwell plank cabextract gnome-disk-utility -y



#mouseacc
sudo tee /usr/share/X11/xorg.conf.d/50-mouse.conf >/dev/null << EOF
Section "InputClass"
	Identifier "Mouse"
	Driver "libinput"
	MatchIsPointer "yes"
	Option "AccelProfile" "flat"
EndSection
EOF

cd "${HOME}/Downloads"
wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
chmod +x winetricks
sudo cp winetricks /usr/local/bin

sudo tee /etc/udev/rules.d/90-xhc_sleep.rules >/dev/null << EOF
# disable wake from S3 on XHC1
SUBSYSTEM=="pci", KERNEL=="0000:00:14.0", ATTR{power/wakeup}="disabled"
EOF

wget https://knapsu.eu/data/plex/Plex_Media_Player_2.17.0.890-7d18e33d_x64.AppImage
sudo curl -o /usr/share/icons/indesign.png https://raw.githubusercontent.com/pstngh/linux/master/o/indesign.png
sudo curl -o /usr/share/icons/photoshop.png https://raw.githubusercontent.com/pstngh/linux/master/o/photoshop.png


#sudo mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/nm-applet.desktopbak
#sudo sed -e '/load-module module-suspend-on-idle/ s/^#*/#/' -i /etc/pulse/default.pa


