
FOLDERS="bash,tmux,urxvt,vim"

for folder in $(echo $FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done

