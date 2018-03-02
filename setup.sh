#!/bin/bash -xe

# Get the directory containing this script (& vimrc etc)
DIR=$(dirname "$(readlink -f "$0")")
# Get timestamp
TIMESTAMP=$(date +"+%Y%m%d%H%M%S")

# Backup current configs and directories if not symlinks, else delete symlink
locations=(
    .vim
    .vimrc
    .config/nvim
    nvim
)
for loc in "${locations[@]}"; do
    if [[ -L $HOME/$loc ]]; then
        rm -f $HOME/$loc
    elif [[ -d $HOME/$loc ]] || [[ -f $HOME/$loc ]]; then
        mv $HOME/$loc $HOME/$loc-bkp-$TIMESTAMP
        printf "Current $loc moved to $HOME/$loc-bkp-$TIMESTAMP\n"
    fi
done

# Create symlinks & necessary directories
ln -s $DIR $HOME/.vim
ln -s $DIR $HOME/nvim
ln -s $DIR $HOME/.config/nvim
ln -s $DIR/.vimrc $HOME/.vimrc

# If needing to reinstall, ensure bundle dir is empty
rm -rf $HOME/.vim/bundle/*

# Get Dein plugin manager
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $HOME/.vim/bundle

# Install bundles
# Use Neovim if available
if [ -x "$(command -v nvim)" ]; then
    nvim -E -u NONE -S $HOME/.config/nvim/init.vim +'call dein#update()' +qall
else
    vim -E -u NONE -S $HOME/.vimrc +'call dein#update()' +qall
fi

printf "Setup done\n"
