#!/bin/bash


#apps
sudo pacman -Syu --noconfirm --needed mpv rhythmbox
#yay -S --noconfirm scribus
#yay -S --noconfirm gimp
#yay -S --noconfirm kodi
#yay -S --noconfirm skypeforlinux-bin
yay -Syu --noconfirm teamviewer-beta
#yay -S --noconfirm tiny-media-manager
#yay -S --noconfirm filebot
#yay -S --noconfirm youtube-dl-gui-git
#yay -S --noconfirm paper-icon-theme-git
#yay -S --noconfirm arc-gtk-theme
#yay -S --noconfirm wire-desktop

#sudo gpasswd -a pulse audio

#sudo cpupower frequency-set -g performance

sudo systemctl enable fstrim.timer

#mouseacc
sudo tee /etc/X11/xorg.conf.d/50-mouse.conf &>/dev/null << EOF
Section "InputClass"
	Identifier "Mouse"
	Driver "libinput"
	MatchIsPointer "yes"
	Option "AccelProfile" "flat"
EndSection
EOF

cd
wget https://download.teamviewer.com/download/version_11x/teamviewer_qs.tar.gz -O teamviewer.tar.xz
tar xf teamviewer.tar.xz

echo ubuntu | sudo -S systemctl enable teamviewerd.service
echo ubuntu | sudo -S systemctl start teamviewerd.service



teamviewer
