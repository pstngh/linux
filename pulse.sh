#!/bin/bash


#apps
sudo pacman -Syu --noconfirm --needed mpv rhythmbox
#yay -S --noconfirm scribus
#yay -S --noconfirm gimp
#yay -S --noconfirm kodi
#yay -S --noconfirm skypeforlinux-bin
#yay -Syu --noconfirm teamviewer-beta
#yay -S --noconfirm tiny-media-manager
#yay -S --noconfirm youtube-dl-gui-git
yay -S --noconfirm paper-icon-theme
yay -S --noconfirm arc-gtk-theme
yay -S --noconfirm wire-desktop
yay -S --noconfirm adapta-gtk-theme
yay -S --noconfirm anydesk
#yay -S --noconfirm brasero

#sudo gpasswd -a pulse audio

#sudo cpupower frequency-set -g performance

sudo systemctl enable fstrim.timer


sudo rm -rf /usr/share/gnome-shell/extensions
wget -O steal-my-focus@kagesenshi.org.zip "https://github.com/tak0kada/gnome-shell-extension-stealmyfocus/archive/master.zip"
#curl -L -O https://github.com/tak0kada/gnome-shell-extension-stealmyfocus/archive/master.zip
unzip steal-my-focus@kagesenshi.org.zip
mv gnome-shell-extension-stealmyfocus-master ~/.local/share/gnome-shell/extensions/steal-my-focus@kagesenshi.org
rm ~/.local/share/gnome-shell/extensions/steal-my-focus@kagesenshi.org/Makefile
rm ~/.local/share/gnome-shell/extensions/steal-my-focus@kagesenshi.org/README.md
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
sudo chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/
gnome-shell-extension-installer 1160 19 118 615 1379 --restart-shell

sudo pacman -R linux
sudo grub-mkconfig -o /boot/grub/grub.cfg
