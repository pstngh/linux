#!/bin/bash

sudo apt-get --purge autoremove thunderbird parole pidgin xfburn gnome-mines gnome-sudoku sgt-puzzles ristretto simple-scan blueman bluez* -y
sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
sudo add-apt-repository ppa:snwh/ppa -y
sudo add-apt-repository ppa:scribus/ppa -y
#
sudo apt update -y
sudo apt install mpv rhythmbox paper-icon-theme arc-theme gimp gnome-disk-utility scribus -y
sudo apt install --install-recommends winehq-stable

#mouseacc
sudo tee /usr/share/X11/xorg.conf.d/50-mouse.conf >/dev/null << EOF
Section "InputClass"
	Identifier "Mouse"
	Driver "libinput"
	MatchIsPointer "yes"
	Option "AccelProfile" "flat"
EndSection
EOF

sudo gpasswd -a pulse audio
#sudo systemctl enable fstrim.timer

wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo dpkg -i teamviewer_amd64.deb

teamviewer
