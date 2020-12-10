#!/bin/bash

# this script create hardlink for the configs files.
# renaming existing ones if found.

if [ -f ~/.bashrc ]; then
    echo "old .bashrc found. Renamed to old.bashrc"
    mv ~/.bashrc ~/old.bashrc
    ln .bashrc ~/.bashrc
else
    ln .bashrc ~/.bashrc
fi

if [ -f ~/.vimrc ]; then
    echo "old .vimrc found. Renamed to old.vimrc"
    mv ~/.vimrc ~/old.vimrc
    ln .vimrc ~/.vimrc
else 
    ln .vimrc ~/.vimrc
fi

if [ -f ~/.Xresources ]; then
    echo "old .Xresourecs found. Renamed to old.Xresources"
    mv ~/.Xresources ~/old.Xresources
    ln .Xresources ~/.Xresources
    xrdb ~/.Xresources
else
    ln .Xresources ~/.Xresources
    xrdb ~/.Xresources
fi

if [ -f ~/.tmux.conf ]; then
    echo "old .tmux.conf found. Renamed to old.tmux.conf
    "
    mv ~/.tmux.conf ~/old.tmux.conf
    ln .tmux.conf ~/.tmux.conf
else
    ln .tmux.conf ~/.tmux.conf
fi


#TODO: install urxvt plugins
