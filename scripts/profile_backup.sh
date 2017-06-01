#!/bin/bash

cp ~/.bashrc ~/profile_backup/
cp ~/.bash_login ~/profile_backup/
cp ~/.bash_logout ~/profile_backup/
cp ~/.inputrc ~/profile_backup/
cp ~/.profile ~/profile_backup/
cp -r ~/scripts ~/profile_backup
cd ~/profile_backup
CURDATE=`date +%Y-%m-%d`
git add .
git commit -am "Profile updates: $CURDATE"
