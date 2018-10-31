#!/bin/bash

# get cufrent dir
dotdir=`dirname $0`
if [[ $dotdir = . ]]; then
    dotdir=`pwd`
fi


# extract vim configs
if [[ -f $HOME/.vimrc ]]; then
    cp $HOME/.vimrc $HOME/.vimrc.backup
fi

rm -rf ~/.vim
cp -R $dotdir/vim/.vim ~/.vim
cp -R $dotdir/vim/.vimrc ~/.vimrc


# extract zsh configs
if [[ -f ~/.zshrc ]]; then
    cp ~/.zshrc ~/.zshrc.backup
fi

cp -R $dotdir/zsh/.zshrc ~/.zshrc


# extract git configs
if [[ -f ~/.gitignore ]]; then
    cp ~/.gitignore ~/.gitignore.backup
fi

cp $dotdir/git/.gitignore ~/.gitignore

if [[ -f ~/.gitconfig ]]; then
    cp ~/.gitconfig ~/.gitconfig.backup
fi

cp $dotdir/git/.gitconfig ~/.gitconfig


echo "dotfiles installed"
