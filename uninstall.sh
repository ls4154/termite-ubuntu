#!/bin/bash

sudo update-alternatives --remove x-terminal-emulator /usr/local/bin/termite.wrapper

sudo rm -f /usr/local/bin/termite.wrapper
sudo rm -f /usr/local/etc/profile.d/vte.sh
sudo rmdir --ignore-fail-on-non-empty /usr/local/etc/profile.d
sudo rm -f /usr/share/terminfo/x/xterm-termite
sudo rmdir --ignore-fail-on-non-empty /usr/share/terminfo/x

sudo rm -f /usr/local/bin/termite
sudo rm -f /etc/xdg/termite/config
sudo rmdir --ignore-fail-on-non-empty /etc/xdg/termite
sudo rm -f /usr/local/share/applications/termite.desktop
sudo rm -f /usr/local/share/man/man1/termite.1
sudo rm -f /usr/local/share/man/man5/termite.config.5
sudo rm -f /usr/local/share/terminfo/x/xterm-termite
sudo rmdir --ignore-fail-on-non-empty /usr/local/share/terminfo/x

