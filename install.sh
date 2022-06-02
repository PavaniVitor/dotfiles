
FOLDERS="bash,tmux,alacritty,nvim"

for folder in $(echo $FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done

