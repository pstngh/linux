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
makepkg -si  --noconfirm

#sudo pacman -Syu --noconfirm --needed xorg-server xorg-apps pulseaudio bash-completion gnome-shell gnome-tweak-tool gnome-control-center xdg-user-dirs lightdm lightdm-gtk-greeter #gdm
sudo pacman -Syu --noconfirm --needed linux-lts xorg-server xorg-apps pulseaudio bash-completion xfce4-whiskermenu-plugin xfce4-pulseaudio-plugin xfce4 noto-fonts ttf-roboto ttf-ubuntu-font-family ttf-dejavu xdg-user-dirs gvfs-mtp libmtp lightdm

#sudo pacman -Rsn thunar geany gvim parole
sudo pacman -Syu --noconfirm --needed xterm remmina nemo nemo-fileroller firefox wine winetricks libvncserver steam mpv pulseeffects calf gameconqueror pavucontrol rhythmbox cpupower steam-native-runtime vulkan-radeon xf86-video-amdgpu mousepad flatpak
#sudo pacman -Syu --noconfirm --needed virtualbox-host-modules-arch virtualbox
yay -S --noconfirm xcursor-breeze
yay -S --noconfirm redshift-minimal
yay -S --noconfirm paper-icon-theme-git
yay -S --noconfirm adapta-gtk-theme
#yay -S --noconfirm flat-remix-gnome-git
yay -S --noconfirm acestream-launcher
yay -S --noconfirm plex-media-player
#yay -S --noconfirm discord
#yay -S --noconfirm protontricks-git
#yay -S --noconfirm ttf-ms-fonts
yay -S --noconfirm makemkv mediainfo-gui mkvtoolnix-gui

sudo pacman -Rdd thunar

#Flatpak
flatpak install flathub com.discordapp.Discord

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
mkdir -p /etc/X11/xorg.conf.d/
sudo tee /etc/X11/xorg.conf.d/20-amdgpu.conf >/dev/null << EOF
Section "Device"
	Identifier "AMD"
	Driver "amdgpu"
	Option "TearFree" "false"
EndSection
EOF

#aliases
if ! grep -q acestream ~/.bashrc; then
tee -a ~/.bashrc >/dev/null << 'EOF'
export WINEDLLOVERRIDES=winemenubuilder.exe=d
ace () { 
acestream-launcher acestream://"$1"
}

cleanwine() {
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
sudo mkdir -p /mnt/Storage
sudo mkdir -p /mnt/ubuntu
if ! grep -q 192.168.1.197 /etc/fstab; then
sudo tee -a /etc/fstab >/dev/null << 'EOF'
LABEL=Storage /mnt/Storage auto nosuid,nodev,nofail,noatime 0 0
//192.168.1.197/ubuntu /mnt/ubuntu cifs vers=1.0,guest,uid=pstn,comment=systemd.automount,nofail,rw,guest 0 0
EOF
fi
sudo mount -a

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

sudo tee /etc/lightdm/lightdm.conf << 'EOF'
[LightDM]
run-directory=/run/lightdm

[Seat:*]
user-session=xfce
session-wrapper=/etc/lightdm/Xsession
autologin-user=pstn
autologin-session=xfce
EOF

#VPN
#yay -S --noconfirm openvpn-update-systemd-resolved

cp -RT /mnt/Storage/Files/config/.config/ ~/.config/
#shortcuts
sudo cp /mnt/Storage/Files/shortcuts/desktop/*.desktop /usr/share/applications
sudo cp /mnt/Storage/Files/scripts/copy/*.png /usr/share/icons

systemctl --user enable redshift
#sudo systemctl enable teamviewerd
sudo systemctl enable cpupower
sudo systemctl enable fstrim.timer
sudo systemctl enable lightdm
#systemctl start gdm
#sudo systemctl enable gdm

mkdir -p ~/.ACEStream
ln -s /mnt/ubuntu/6TB/.acestream_cache ~/.ACEStream

#sudo systemctl enable systemd-networkd-wait-online
xdg-user-dirs-update
xdg-user-dirs-update --set MUSIC /mnt/Storage/Music
xdg-user-dirs-update --set DOWNLOAD /mnt/ubuntu/6TB/dl

#winetricks
#winetricks corefonts
#winetricks tahoma

#sudo pacman -Rscn --noconfirm thunar

#esync
sudo sed -i 's/^#DefaultLimitNOFILE=$/DefaultLimitNOFILE=1048576/g' /etc/systemd/system.conf /etc/systemd/user.conf
sudo systemctl daemon-reexec

sudo pacman -R linux
sudo grub-mkconfig -o /boot/grub/grub.cfg



