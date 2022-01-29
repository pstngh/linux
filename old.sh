
sudo tee /etc/X11/xorg.conf.d/10-monitor.conf >/dev/null << EOF
Section "Monitor"
    Identifier "DisplayPort-0"
    Modeline "800x600_144.00"  102.50  800 864 944 1088  600 603 607 655 -hsync +vsync
    Option "PreferredMode" "800x600_144.00"
EndSection
EOF







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






xdg-user-dirs-update
xdg-user-dirs-update --set MUSIC /mnt/Storage/Music
xdg-user-dirs-update --set DOWNLOAD /mnt/ubuntu/6TB/Downloads
xdg-user-dirs-update --set PICTURES /mnt/Storage/Files/wallpaper


#sudo pacman -Rscn --noconfirm thunar
#yay -S --noconfirm discord
#yay -S --noconfirm protontricks-git
#yay -S --noconfirm ttf-ms-fonts

#xset dpms 0 0 600

#VPN
#yay -S --noconfirm openvpn-update-systemd-resolved
#systemctl enable --now systemd-resolved.service
#sudo openvpn --config x.ovpn

#gsettings set org.cinnamon.desktop.default-applications.terminal exec 'termite'

#sudo systemctl enable systemd-networkd-wait-online

#amdgpu_tweaks
#mkdir -p /etc/X11/xorg.conf.d/
#sudo tee /etc/X11/xorg.conf.d/20-amdgpu.conf >/dev/null << EOF
#Section "Device"
#	Identifier "AMD"
#	Driver "amdgpu"
#	Option "TearFree" "false"
#EndSection
#EOF


#yay -S --noconfirm makemkv mediainfo-gui mkvtoolnix-gui flat-remix-gnome-git

#sudo sh -c 'echo sg > /etc/modules-load.d/sg.conf'
#sudo pacman -Rdd thunar

#yay -S --noconfirm plex-media-player


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
gsettings set org.gnome.rhythmbox.rhythmdb locations ['file:///mnt/Storage/Music']
gsettings set org.gnome.shell favorite-apps '['org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'firefox.desktop', 'fsearch.desktop', 'night.desktop', '144hz.desktop', 'clone.desktop', 'vnc.desktop', 'rhythmbox.desktop', 'steam-native.desktop']'



