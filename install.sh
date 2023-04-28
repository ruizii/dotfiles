#!/bin/bash

CYAN='\033[0;36m'
BLUE='\033[0;34m'
ENDCOLOR='\033[0m'

echo -e "\n${BLUE}Instalando dotfiles en:${ENDCOLOR}"
echo -e "\n\t${CYAN}${HOME}/.config/kitty/kitty.conf${ENDCOLOR}"
echo -e "\t${CYAN}${HOME}/.config/nvim/init.vim${ENDCOLOR}"
echo -e "\t${CYAN}${HOME}/.zshrc${ENDCOLOR}"

mkdir -p ${HOME}/.config/kitty
mkdir -p ${HOME}/.config/nvim

rm ${HOME}/.zshrc
rm ${HOME}/.config/kitty/kitty.conf
rm ${HOME}/.config/nvim/init.vim

ln -s $(pwd)/kitty.conf ${HOME}/.config/kitty/kitty.conf
ln -s $(pwd)/init.vim ${HOME}/.config/nvim/init.vim
ln -s $(pwd)/zshrc ${HOME}/.zshrc