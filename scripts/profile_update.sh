#!/bin/bash

cd ~/profile_backup
git pull
cp ~/profile_backup/.bashrc ~/
cp ~/profile_backup/.bash_login ~/
cp ~/profile_backup/.bash_logout ~/
cp ~/profile_backup/.inputrc ~/
cp ~/profile_backup/.profile ~/
cp -r ~/profile_backup/scripts ~/
