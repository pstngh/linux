#!/bin/bash

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=121PKLtd5K5sWcJqXqlAJWDK6DIcRT_NG' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=121PKLtd5K5sWcJqXqlAJWDK6DIcRT_NG" -O mohaa.zip && rm -rf /tmp/cookies.txt

sudo dpkg --add-architecture i386
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install libstdc++5:i386 -y
sudo apt install unzip -y
unzip mohaa.zip
cd mohaa
chmod 777 mohaa_lnxded
