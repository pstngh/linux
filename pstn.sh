#!/bin/bash


sudo pacman -Syu --noconfirm --needed xorg-server xorg-apps lightdm xfce4 yay pulseaudio bash-completion #ttf-roboto ttf-ubuntu-font-family scrot
#sudo pacman -Syu --noconfirm --needed gpicview gvfs-smb lxappearance-obconf nitrogen gsimplecal volumeicon lxsession tint2 # polkit-gnome numix-gtk-theme numix-frost-themes ttf-ubuntu-font-family

sudo tee /etc/lightdm/lightdm.conf << 'EOF'
[LightDM]
run-directory=/run/lightdm

[Seat:*]
user-session=xfce
session-wrapper=/etc/lightdm/Xsession
autologin-user=pstn
autologin-session=xfce
EOF

#sudo pacman -Rsn thunar geany gvim parole
sudo pacman -Syu --noconfirm --needed xterm remmina nemo nemo-fileroller termite firefox wine winetricks libvncserver steam mpv pulseeffects calf gameconqueror pavucontrol rhythmbox cpupower steam-native-runtime vulkan-radeon xf86-video-amdgpu
#sudo pacman -Syu --noconfirm --needed virtualbox-host-modules-arch virtualbox
#yay -S --noconfirm fsearch-git
yay -S --noconfirm xcursor-breeze
yay -S --noconfirm redshift-minimal
yay -S --noconfirm paper-icon-theme-git
yay -S --noconfirm arc-gtk-theme
yay -S --noconfirm acestream-launcher
yay -S --noconfirm plex-media-player
#yay -S --noconfirm ttf-ms-fonts
yay -S --noconfirm protontricks-git
#yay -S --noconfirm makemkv mediainfo-gui mkvtoolnix-gui
#yay -S --noconfirm teamviewer


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
WINEDLLOVERRIDES=winemenubuilder.exe=d
ace () { 
acestream-launcher acestream://"$1"
}
EOF
fi


##swappiness
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
//192.168.1.197/ubuntu /mnt/ubuntu cifs guest,uid=pstn,comment=systemd.automount,nofail,rw,guest 0 0
EOF
fi
sudo mount -a

gsettings set org.cinnamon.desktop.default-applications.terminal exec 'termite'

#limit journal size
sudo sed -i '/SystemMaxUse/ s/.*/SystemMaxUse=10M/' /etc/systemd/journald.conf
sudo sed -i '/MAKEFLAGS=/s/^.*$/MAKEFLAGS=\"-j\$(nproc)\"/' /etc/makepkg.conf
sudo sed -e '/load-module module-suspend-on-idle/ s/^#*/#/' -i /etc/pulse/default.pa

#cpupower
sudo tee /etc/default/cpupower >/dev/null << EOF
governor='performance'
EOF

cp -RT /mnt/Storage/Files/scripts/config/.config/ ~/.config/
#shortcuts
sudo cp /mnt/Storage/Files/shortcuts/desktop/*.desktop /usr/share/applications
sudo cp /mnt/Storage/Files/scripts/copy/*.png /usr/share/icons

systemctl --user enable redshift
#sudo systemctl enable teamviewerd
sudo systemctl enable cpupower
sudo systemctl enable fstrim.timer
#sudo systemctl enable lightdm

sudo grub-mkconfig -o /boot/grub/grub.cfg

mkdir -p ~/.ACEStream
ln -s /mnt/ubuntu/6TB/.acestream_cache ~/.ACEStream

#sudo systemctl enable systemd-networkd-wait-online
#remove network tray icon
#sudo mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/nm-applet.desktopbak
xdg-user-dirs-update --set MUSIC /mnt/Storage/Music
xdg-user-dirs-update --set DOWNLOAD /mnt/ubuntu/6TB/dl
#timedatectl set-local-rtc 1 --adjust-system-clock


#winetricks
#winetricks corefonts

#clean up wine associations
sudo rm /usr/share/applications/wine*.desktop
rm ~/.local/share/applications/wine*.desktop
rm ~/.local/share/applications/wine-*
rm -f ~/.local/share/applications/wine-extension*.desktop
rm -f ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
rm -f ~/.local/share/applications/mimeinfo.cache
rm -f ~/.local/share/mime/packages/x-wine*
rm -f ~/.local/share/mime/application/x-wine-extension*
#or all
#find ~/.local/share -name "*wine*" | xargs --no-run-if-empty rm -r
update-desktop-database ~/.local/share/applications
update-mime-database ~/.local/share/mime/


if ! grep -q "\[multilib\]" /etc/pacman.conf; then
sudo tee -a /etc/pacman.conf >/dev/null << EOF
[multilib]
Include = /etc/pacman.d/mirrorlist
EOF
else
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
fi
