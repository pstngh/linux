#!/bin/bash

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S2mpjaYgibyt_64Xgxpbvf8sAWEd6fuj' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S2mpjaYgibyt_64Xgxpbvf8sAWEd6fuj" -O mohaa.zip && rm -rf /tmp/cookies.txt

sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install libstdc++6:i386
sudo apt install unzip
unzip mohaa.zip
cd mohaa
chmod 777 mohaa_lnxded
