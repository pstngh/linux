#!/bin/bash

if ! grep -q "\[multilib\]" /etc/pacman.conf; then
sudo tee -a /etc/pacman.conf >/dev/null << EOF
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
else
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
fi
#sudo sh -c "sed -i '/\[multilib\]/,/Include/s/^[ ]*#//' /etc/pacman.conf"

sudo groupadd -r autologin
sudo gpasswd -a pstn autologin

sudo pacman -Syu --noconfirm git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

sudo pacman -Syu --noconfirm --needed xorg-server xorg-apps pulseaudio bash-completion gnome-shell gnome-tweak-tool gnome-control-center xdg-user-dirs gdm gnome-calculator gnome-terminal gnome-disk-utility bluez bluez-utils fuse2 wget
sudo pacman -Syu --noconfirm --needed xterm remmina nemo gvfs-mtp nemo-fileroller gthumb firefox android-tools wine winetricks libvncserver steam mpv pavucontrol rhythmbox cpupower steam-native-runtime gedit gnome-system-monitor
sudo pacman -S --noconfirm ttf-roboto noto-fonts xf86-video-amdgpu vulkan-radeon #flatpak
#yay -S --noconfirm redshift-minimal
yay -S --noconfirm paper-icon-theme


#mouseacc
mkdir -p /etc/X11/xorg.conf.d/
sudo tee /etc/X11/xorg.conf.d/50-mouse.conf >/dev/null << EOF
Section "InputClass"
	Identifier "Mouse"
	Driver "libinput"
	MatchIsPointer "yes"
	Option "AccelProfile" "flat"
EndSection
EOF





#swappiness
mkdir -p /etc/sysctl.d/
if ! grep -q vm.swappiness /etc/sysctl.d/99-sysctl.conf; then
sudo tee -a /etc/sysctl.d/99-sysctl.conf >/dev/null << EOF
vm.swappiness=0
EOF
else
sed -i '/vm\.swappiness/ s/.*/vm.swappiness=0/' /etc/sysctl.d/99-sysctl.conf
fi

sudo sysctl --system


#limit journal size
sudo sed -i '/SystemMaxUse/ s/.*/SystemMaxUse=10M/' /etc/systemd/journald.conf
sudo sed -i '/MAKEFLAGS=/s/^.*$/MAKEFLAGS=\"-j\$(nproc)\"/' /etc/makepkg.conf
sudo sed -i '/PKGEXT=/s/^.*$/PKGEXT=\".pkg.tar\"/' /etc/makepkg.conf
sudo sed -e '/load-module module-suspend-on-idle/ s/^#*/#/' -i /etc/pulse/default.pa

#cpupower
sudo tee /etc/default/cpupower >/dev/null << EOF
governor='performance'
EOF


#systemctl --user enable redshift
sudo systemctl enable cpupower
sudo systemctl enable fstrim.timer


#install gnome extensions
sudo rm -rf /usr/share/gnome-shell/extensions
#curl -L -O https://github.com/tak0kada/gnome-shell-extension-stealmyfocus/archive/master.zip
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
sudo chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/
gnome-shell-extension-installer 1160 19 118 615 1379 --restart-shell #1236


#winetricks
winetricks corefonts
winetricks tahoma

#esync
sudo sed -i 's/^#DefaultLimitNOFILE=$/DefaultLimitNOFILE=1048576/g' /etc/systemd/system.conf /etc/systemd/user.conf
sudo systemctl daemon-reexec



#XFCE
#sudo pacman -Syu --noconfirm -needed xorg-server xorg-apps lightdm-gtk-greeter xfce4 bash-completion
#sudo pacman -Rs xfce4-power-manager xfwm4-themes xfce4-appfinder tumbler thunar-volman
