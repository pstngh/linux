#!/bin/bash


apt-get update -y
apt-get upgrade -y
apt-get install libstdc++5:i386 -y
apt install unzip -y
apt install fail2ban -y
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1LRrh5ZYHPMz1KF3KNPv_Eu3nqkR1hTel' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1LRrh5ZYHPMz1KF3KNPv_Eu3nqkR1hTel" -O mohaa.zip && rm -rf /tmp/cookies.txt
unzip mohaa.zip
cd mohaa
chmod 775 ./mohaa_lnxded ./gs.sh ./gsload.sh
