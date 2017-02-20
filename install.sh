#!/bin/bash -eux
mkdir /usr/share/applications
mkdir -p /usr/share/icons/hicolor/scalable/apps
dpkg -i /root/j805_amd64.deb
apt-get update
apt-get install -y \
  libqt5multimedia5 \
  libqt5webkit5 \
  libqt5websockets5 \
  qt5-default \
  wget
mkdir -p /root/j64-805-user/temp
INSTALL=$(mktemp "/tmp/tmp.XXXXXXXXXX.ijs")
printf "install'all'\nexit''" >"$INSTALL"
ijconsole "$INSTALL"
rm "$INSTALL"
mkdir /data
