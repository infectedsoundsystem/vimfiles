#!/bin/bash

# Get the directory containing this script (& vimrc etc)
DIR=$(dirname "$(readlink -f "$0")")
# Get timestamp
TIMESTAMP=$(date +"+%Y%m%d%H%M%S")

# Backup current configs and directories if not symlinks, else delete symlink
locations=(
    .vim
    .vimrc
    .config/nvim/init.vim
    nvim
)
for loc in locations; do
    if [[ -d $HOME/$loc ]]; then
        if [[ -L $HOME/$loc ]]; then
            rm -f $HOME/$loc
        else
            mv $HOME/$loc $HOME/$loc-bkp-$TIMESTAMP
            printf "Current $loc moved to $HOME/$loc-bkp-$TIMESTAMP\n"
        fi
    fi
done

# Create symlinks & necessary directories
ln -s $DIR $HOME/.vim
ln -s $DIR $HOME/nvim
ln -s $DIR/.vimrc $HOME/.vimrc
mkdir -p $HOME/.config/nvim
ln -s $DIR/.vimrc $HOME/.vimrc

# If needing to reinstall, ensure bundle dir is empty
rm -rf $HOME/.vim/bundle/*

# Get Dein plugin manager
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $HOME/.vim/bundle

# Install bundles
printf "Installing bundles, this may take a couple of minutes...\n"

# Use Neovim if available
if [ -x "$(command -v nvim)" ]; then
    nvim +'call dein#update()' +qall
else
    vim -E -u NONE -S $HOME/.vimrc +'call dein#update()' +qall
fi

printf "Setup done\n"
