#!/bin/bash

sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
sudo add-apt-repository ppa:atareao/telegram
sudo apt update
sudo apt upgrade
sudo apt install --no-install-recommends curl telegram gnome-disk-utility wget -y
sudo apt install --install-recommends winehq-stable -y
#spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt install spotify-client -y
wget -O ~/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install ~/discord.deb -y
sudo snap install tradingview
sudo apt purge --autoremove

#swap disable
sudo swapoff -a
sudo sed -i '/swapfile/d' /etc/fstab
#sudo sed -i '/ swap / s/^/#/' /etc/fstab
#sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


# __GL_ExtensionStringVersion=17700 wine ./MOHAA.EXE

