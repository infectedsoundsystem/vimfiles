#!/bin/bash

# Get the directory containing this script (& vimrc etc)
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# Get timestamp
TIMESTAMP=$(date +"+%Y%m%d%H%M%S")

# Backup current .vim and .vimrc if not symlinks, else delete symlink
if [[ -d $HOME/.vim ]]; then
    if [[ -L $HOME/.vim ]]; then
        rm -f $HOME/.vim
    else
        mv $HOME/.vim $HOME/.vim-bkp-$TIMESTAMP
        printf "Current .vim directory moved to $HOME/.vim-bkp-$TIMESTAMP\n"
    fi
fi
if [[ -f $HOME/.vimrc ]]; then
    if [[ -L $HOME/.vimrc ]]; then
        rm -f $HOME/.vimrc
    else
        mv $HOME/.vimrc $HOME/.vimrc-bkp-$TIMESTAMP
        printf "Current .vimrc moved to $HOME/.vimrc-bkp-$TIMESTAMP\n"
    fi
fi

# Create symlinks & necessary directories
ln -s $DIR $HOME/.vim
ln -s $DIR/.vimrc $HOME/.vimrc
mkdir $HOME/.vim/bundle
mkdir $HOME/.vim/temp

# If needing to reinstall, ensure bundle dir is empty
rm -rf $HOME/.vim/bundle/*

# Get NeoBundle
git clone https://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim

# Install bundles
printf "Installing bundles, this may take a couple of minutes...\n"
#vim +NeoBundleInstall +qall
vim -E -u NONE -S $HOME/.vimrc +NeoBundleInstall +qall

printf "Setup done\n"
