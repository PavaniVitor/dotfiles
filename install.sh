
FOLDERS="bash,tmux,urxvt,nvim"

for folder in $(echo $FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done

