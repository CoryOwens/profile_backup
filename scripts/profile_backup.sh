#!/bin/bash

cp ~/.bashrc ~/profile_backup/
cp ~/.bash_login ~/profile_backup/
cp ~/.bash_logout ~/profile_backup/
cp ~/.inputrc ~/profile_backup/
cp ~/.profile ~/profile_backup/
cp -r ~/scripts ~/profile_backup
mkdir -p ~/profile_backup/.config
cp -r ~/.config/i3 ~/profile_backup/.config
cp -r ~/.config/i3status ~/profile_backup/.config
cp -r ~/.config/terminator ~/profile_backup/.config
mkdir -p ~/profile_backup/.config/sublime-text-3
cp -r ~/.config/sublime-text-3/Installed\ Packages ~/profile_backup/.config/sublime-text-3
cp -r ~/.config/sublime-text-3/Packages ~/profile_backup/.config/sublime-text-3
mkdir -p ~/profile_backup/.PyCharm2017.2/config/options
cp ~/.PyCharm2017.2/config/options/keymap.xml ~/profile_backup/.PyCharm2017.2/config/options
cd ~/profile_backup
CURDATE=`date +%Y-%m-%d`
git add .
git commit -am "Profile updates: $CURDATE"
git push
