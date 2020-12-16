#!/bin/bash

# this script create hardlink for the configs files.
# renaming existing ones if found.

if [ -f ~/.bashrc ]; then
    echo "old .bashrc found. Renamed to old.bashrc"
    mv ~/.bashrc ~/old.bashrc
fi
ln .bashrc ~/.bashrc

if [ -f ~/.vimrc ]; then
    echo "old .vimrc found. Renamed to old.vimrc"
    mv ~/.vimrc ~/old.vimrc
fi
ln .vimrc ~/.vimrc

if [ -f ~/.Xresources ]; then
    echo "old .Xresourecs found. Renamed to old.Xresources"
    mv ~/.Xresources ~/old.Xresources
fi
ln .Xresources ~/.Xresources
xrdb ~/.Xresources

if [ -f ~/.tmux.conf ]; then
    echo "old .tmux.conf found. Renamed to old.tmux.conf"
    mv ~/.tmux.conf ~/old.tmux.conf
fi
ln .tmux.conf ~/.tmux.conf

#TODO: install urxvt plugins

