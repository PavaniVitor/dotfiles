o#i/bin/bash

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

# create urxvt scripts folder
mkdir -p ~/.urxvt/ext/

# link scripts to folder

ln urxvt-perls/keyboard-select /home/vitor/.urxvt/ext/keyboard-select
ln urxvt-resize-font/resize-font /home/vitor/.urxvt/ext/resize-font
# fullscreen needs wmctrl to work"
ln urxvt-perl/fullscreen /home/vitor/.urxvt/ext/fullscreen

