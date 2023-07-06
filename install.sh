
FOLDERS="bash,tmux,alacritty,nvim,git,rofi"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for folder in $(echo $FOLDERS | sed "s/,/ /g")
do
    stow -D --target="$HOME" --dir="$SCRIPT_DIR" $folder
    stow -S --target="$HOME" --dir="$SCRIPT_DIR" $folder
done

