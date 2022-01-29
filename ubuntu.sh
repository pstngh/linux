#!/bin/bash

snap remove snap-store
sudo apt purge --autoremove pidgin
sudo apt purge --autoremove gnome-software
sudo apt purge --autoremove libreoffice-draw
sudo apt purge --autoremove bluez
sudo apt purge --autoremove simple-scan
sudo apt purge --autoremove xfce4-dict
sudo apt purge --autoremove libreoffice-math
sudo apt purge --autoremove yelp
sudo apt purge --autoremove thunderbird
sudo apt purge --autoremove transmission-gtk
sudo apt purge --autoremove gucharmap
sudo apt purge --autoremove snapd
sudo apt purge --autoremove gnome-mines
sudo apt purge --autoremove gnome-sudoku
sudo apt purge --autoremove sgt-puzzles
sudo apt purge --autoremove xfburn
sudo apt purge --autoremove parole
sudo apt purge --autoremove gigolo
sudo apt purge --autoremove onboard
sudo apt purge --autoremove gimp
sudo apt purge --autoremove apport
sudo apt purge --autoremove popularity-contest
sudo apt purge --autoremove gnome-bluetooth
sudo apt purge --autoremove gnome-characters
sudo apt purge --autoremove gnome-accessibility-themes
sudo apt purge --autoremove gnome-font-viewer
sudo apt purge --autoremove xfce4-netload-plugin
sudo apt purge --autoremove xfce4-mailwatch-plugin
sudo apt purge --autoremove xfce4-screensaver
sudo apt purge --autoremove xfce4-notes
sudo apt purge --autoremove engrampa
sudo apt purge --autoremove info
sudo apt purge --autoremove vim-common
sudo apt purge --autoremove xfce4-power-manager-plugins
sudo apt purge --autoremove 
sudo apt purge --autoremove 

#read -n 1 -s -r -p "Press any key to continue"
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
#sudo add-apt-repository ppa:fossfreedom/rhythmbox-plugins -y
sudo add-apt-repository ppa:atareao/telegram
sudo add-apt-repository ppa:papirus/papirus
sudo apt update
sudo apt upgrade
sudo apt install --no-install-recommends curl telegram arc-theme gnome-disk-utility rhythmbox vlc mpv wget papirus-icon-theme gnome-tweak-tool -y #xdg-desktop-portal-gtk ssh sshpass rhythmbox-plugin-close-on-hide
sudo apt install --install-recommends winehq-stable -y
#spotify
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt install spotify-client -y
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install ~/discord.deb -y
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install ./teamviewer_amd64.deb -y


#mouseacc
sudo mkdir -p /etc/X11/xorg.conf.d/
sudo tee /etc/X11/xorg.conf.d/50-mouse.conf >/dev/null << EOF
Section "InputClass"
	Identifier "Mouse"
	Driver "libinput"
	MatchIsPointer "yes"
	Option "AccelProfile" "flat"
EndSection
EOF


#mkdir -p /home/pstn/.config/redshift/
#sudo tee /home/pstn/.config/redshift/redshift.conf >/dev/null << EOF
Section "InputClass"
	[redshift]
	;temp-day=5700
	temp-night=4500
	transition=1
	location-provider=manual
	adjustment-method=randr
	[manual]
	lat=45.5
	lon=-73.5
EndSection
#EOF

#systemctl --user enable redshift.service

#CPU GOVERNOR
sudo apt-get install cpufrequtils
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo systemctl disable ondemand

#swap disable
sudo swapoff -a
sudo sed -i '/swapfile/d' /etc/fstab
#sudo sed -i '/ swap / s/^/#/' /etc/fstab
#sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#/etc/default/grub mitigations=off
#sudo update-grub

echo "alias ffa='sshpass -p pKdTxU6XY2user ssh ubuntu@185.107.96.110 -p 22010'" >> ~/.bashrc

# __GL_ExtensionStringVersion=17700 wine ./MOHAA.EXE

#gsettings set org.cinnamon.desktop.default-applications.terminal exec xfce4-terminal
#sudo gsettings set org.cinnamon.desktop.default-applications.terminal exec xfce4-terminal
#gsettings set org.gnome.desktop.interface enable-animations false
#gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false

