#!/bin/bash

snap remove snap-store
#sudo apt purge --autoremove pidgin bluez gnome-software libreoffice-draw libreoffice-draw simple-scan xfce4-dict libreoffice-math yelp thunderbird transmission-gtk gucharmap snapd gnome-mines gnome-sudoku sgt-puzzles xfburn parole gigolo onboard gimp apport popularity-contest
#sudo apt purge --autoremove nautilus gnome-bluetooth gnome-characters gnome-accessibility-themes gnome-font-viewer xfce4-netload-plugin xfce4-mailwatch-plugin xfce4-screensaver xfce4-notes engrampa info thunar* vim-common xfce4-power-manager-plugins -y
#read -n 1 -s -r -p "Press any key to continue"
#sudo dpkg --add-architecture i386
#wget -nc https://dl.winehq.org/wine-builds/winehq.key
#sudo apt-key add winehq.key
#sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo add-apt-repository ppa:fossfreedom/rhythmbox-plugins -y
sudo add-apt-repository ppa:atareao/telegram
sudo apt update
sudo apt upgrade
sudo apt install --no-install-recommends spotify-client telegram arc-theme gnome-disk-utility rhythmbox remmina vlc mpv ssh nemo sshpass wget wine-stable gdebi-core rhythmbox-plugin-close-on-hide paper-icon-theme gnome-tweak-tool -y #xdg-desktop-portal-gtk
#echo export 'XDG_DATA_DIRS="/opt/myapp/share:$XDG_DATA_DIRS"' >> ~/.xsessionrc

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

