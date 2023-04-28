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
mkdir -p ${HOME}/.local/share/fonts

rm ${HOME}/.zshrc
rm ${HOME}/.config/kitty/kitty.conf
rm ${HOME}/.config/nvim/init.vim

wget --no-verbose https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip -O ${HOME}/.local/share/fonts/
unzip ${HOME}/.local/share/fonts/FiraCode.zip
rm ${HOME}/.local/share/fonts/FiraCode.zip

ln -s $(pwd)/kitty.conf ${HOME}/.config/kitty/kitty.conf
ln -s $(pwd)/init.vim ${HOME}/.config/nvim/init.vim
ln -s $(pwd)/zshrc ${HOME}/.zshrc
