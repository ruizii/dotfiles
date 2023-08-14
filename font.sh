#!/bin/bash

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip &>/dev/null
mkdir font
mkdir -p ~/.local/share/fonts
mv CascadiaCode.zip font/
unzip ./font/CascadiaCode.zip -d ./font/ &>/dev/null
cp ./font/CaskaydiaCoveNerdFont-Regular.ttf ~/.local/share/fonts/
rm -rf font/
