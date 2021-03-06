# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

PATH=$PATH:/opt/sublime_text/
PATH=$PATH:/snap/bin
# PATH=$PATH:/opt/pycharm-2016.3.2/bin/

# Fixes issue where Pycharm becomes unresponsive to keyboard
# See https://youtrack.jetbrains.com/issue/IDEA-78860
export IBUS_ENABLE_SYNC_MODE=1 
# xrandr \
# --output DP-5 --auto --primary \
# --output DP-0 --auto --right-of DP-5 \
# --output DP-2 --auto --right-of DP-0 \
# --output HDMI-0 --auto --right-of DP-2;
