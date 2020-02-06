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

sudo pacman -Syu --noconfirm --needed xorg-server xorg-apps pulseaudio bash-completion gnome-shell gnome-tweak-tool gnome-control-center xdg-user-dirs gdm gnome-calculator gnome-terminal gnome-disk-utility bluez bluez-utils
#sudo pacman -Syu --noconfirm -needed xorg-server xorg-apps lightdm-gtk-greeter xfce4 bash-completion
#sudo pacman -Rs xfce4-power-manager xfwm4-themes xfce4-appfinder tumbler thunar-volman
sudo pacman -Syu --noconfirm --needed xterm remmina nemo gvfs-mtp nemo-fileroller gthumb firefox android-tools wine winetricks libvncserver steam mpv pavucontrol rhythmbox cpupower steam-native-runtime mousepad gnome-system-monitor
#sudo pacman -Syu --noconfirm --needed virtualbox-host-modules-arch virtualbox xf86-video-amdgpu pulseeffects calf flatpak vulkan-radeon
sudo pacman -S ttf-roboto noto-fonts
yay -Syy --noconfirm flirc-bin
yay -S --noconfirm xcursor-breeze
yay -S --noconfirm redshift-minimal
yay -S --noconfirm paper-icon-theme-git
yay -S --noconfirm adapta-gtk-theme
yay -S --noconfirm acestream-launcher
#yay -S --noconfirm plex-media-player
#yay -S --noconfirm scrcpy

#yay -S --noconfirm makemkv mediainfo-gui mkvtoolnix-gui flat-remix-gnome-git

#sudo sh -c 'echo sg > /etc/modules-load.d/sg.conf'
#sudo pacman -Rdd thunar
#Flatpak
#flatpak install flathub com.discordapp.Discord

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

#amdgpu_tweaks
#mkdir -p /etc/X11/xorg.conf.d/
#sudo tee /etc/X11/xorg.conf.d/20-amdgpu.conf >/dev/null << EOF
#Section "Device"
#	Identifier "AMD"
#	Driver "amdgpu"
#	Option "TearFree" "false"
#EndSection
#EOF

#aliases
if ! grep -q acestream ~/.bashrc; then
tee -a ~/.bashrc >/dev/null << 'EOF'
export WINEDLLOVERRIDES=winemenubuilder.exe=d
ace () { 
acestream-launcher acestream://"$1"
}

cleanwine () {
rm ~/.local/share/applications/wine*.desktop
rm ~/.local/share/applications/wine-*
rm -f ~/.local/share/applications/wine-extension*.desktop
rm -f ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
rm -f ~/.local/share/applications/mimeinfo.cache
rm -f ~/.local/share/mime/packages/x-wine*
rm -f ~/.local/share/mime/application/x-wine-extension*
find ~/.local/share -name "*wine*" | xargs --no-run-if-empty rm -r
#sudo rm /usr/share/applications/wine*.desktop
update-desktop-database ~/.local/share/applications
update-mime-database ~/.local/share/mime/
}
EOF
fi

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


#NETWORK SHARE
#sudo mkdir -p /mnt/Storage
#sudo mkdir -p /mnt/ubuntu
#if ! grep -q 192.168.1.197 /etc/fstab; then
#sudo tee -a /etc/fstab >/dev/null << 'EOF'
#LABEL=Storage /mnt/Storage auto nosuid,nodev,nofail,noatime 0 0
#//192.168.1.197/ubuntu /mnt/ubuntu cifs vers=1.0,guest,uid=pstn,comment=systemd.automount,nofail,rw,guest 0 0
#EOF
#fi
#sudo mount -a

#gsettings set org.cinnamon.desktop.default-applications.terminal exec 'termite'

#limit journal size
sudo sed -i '/SystemMaxUse/ s/.*/SystemMaxUse=10M/' /etc/systemd/journald.conf
sudo sed -i '/MAKEFLAGS=/s/^.*$/MAKEFLAGS=\"-j\$(nproc)\"/' /etc/makepkg.conf
sudo sed -i '/PKGEXT=/s/^.*$/PKGEXT=\".pkg.tar\"/' /etc/makepkg.conf
sudo sed -e '/load-module module-suspend-on-idle/ s/^#*/#/' -i /etc/pulse/default.pa

#cpupower
sudo tee /etc/default/cpupower >/dev/null << EOF
governor='performance'
EOF

#VPN
#yay -S --noconfirm openvpn-update-systemd-resolved
#systemctl enable --now systemd-resolved.service
#sudo openvpn --config x.ovpn


cp -RT /mnt/Storage/Files/config/.config/ ~/.config/
#shortcuts
sudo cp /mnt/Storage/Files/shortcuts/desktop/*.desktop /usr/share/applications
sudo cp /mnt/Storage/Files/scripts/copy/*.png /usr/share/icons

systemctl --user enable redshift
sudo systemctl enable cpupower
sudo systemctl enable fstrim.timer
sudo systemctl enable gdm

mkdir -p ~/.ACEStream
ln -s /mnt/ubuntu/6TB/.acestream_cache ~/.ACEStream

#sudo systemctl enable systemd-networkd-wait-online
xdg-user-dirs-update
xdg-user-dirs-update --set MUSIC /mnt/Storage/Music
xdg-user-dirs-update --set DOWNLOAD /mnt/ubuntu/6TB/Downloads
xdg-user-dirs-update --set PICTURES /mnt/Storage/Files/wallpaper

####GNOME TWEAKS
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'
gsettings set org.gnome.desktop.interface icon-theme 'Paper'
gsettings set org.gnome.desktop.background show-desktop-icons 'true'
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'strict'
gsettings set org.gnome.desktop.interface enable-animations 'false'
gsettings set org.gnome.desktop.peripherals.mouse accel-profile 'flat'
gsettings set org.gnome.desktop.wm.preferences num-workspaces '1'
gsettings set org.gnome.desktop.interface clock-format '12h'
gsettings set org.gnome.desktop.interface cursor-theme 'Breeze'
gsettings set org.gnome.desktop.interface gtk-theme 'Adapta-Nokto-Eta'
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'strict'
gsettings set org.gnome.desktop.wm.preferences num-workspaces '1'
gsettings set org.gnome.desktop.notifications show-banners 'false'
gsettings set org.gnome.desktop.notifications show-in-lock-screen 'false'
gsettings set org.gnome.desktop.privacy disable-camera 'true'
gsettings set org.gnome.desktop.privacy remember-recent-files 'false'
gsettings set org.gnome.desktop.privacy remember-app-usage 'false'
gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
gsettings set org.gnome.desktop.search-providers disable-external 'true'
gsettings set org.gnome.desktop.session idle-delay '0'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.shell favorite-apps ['firefox.desktop', 'nemo.desktop', 'rhythmbox.desktop', 'plex.desktop', 'vnc.desktop', 'steam-native.desktop', 'windows.desktop', 'org.gnome.Terminal.desktop']


#gsettings set org.gnome.rhythmbox.rhythmdb locations ['file:///mnt/Storage/Music']


#gsettings set org.gnome.shell favorite-apps '['org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'firefox.desktop', 'fsearch.desktop', 'night.desktop', '144hz.desktop', 'clone.desktop', 'vnc.desktop', 'rhythmbox.desktop', 'steam-native.desktop']'


#gsettings set org.gnome.nautilus.icon-view default-zoom-level 'small'


#install gnome extensions
sudo rm -rf /usr/share/gnome-shell/extensions
#curl -L -O https://github.com/tak0kada/gnome-shell-extension-stealmyfocus/archive/master.zip
wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
sudo chmod +x gnome-shell-extension-installer
sudo mv gnome-shell-extension-installer /usr/bin/
gnome-shell-extension-installer 1160 19 118 615 1379 --restart-shell #1236


#winetricks
#winetricks corefonts
#winetricks tahoma

#sudo pacman -Rscn --noconfirm thunar
#yay -S --noconfirm discord
#yay -S --noconfirm protontricks-git
#yay -S --noconfirm ttf-ms-fonts
#esync
sudo sed -i 's/^#DefaultLimitNOFILE=$/DefaultLimitNOFILE=1048576/g' /etc/systemd/system.conf /etc/systemd/user.conf
sudo systemctl daemon-reexec
#xset dpms 0 0 600
#sudo pacman -R linux
#sudo grub-mkconfig -o /boot/grub/grub.cfg
