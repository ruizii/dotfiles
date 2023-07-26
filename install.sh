#!/bin/bash

BLUE='\033[0;34m'
ENDCOLOR='\033[0m'

sudo apt install kitty npm python3-venv bat ripgrep nodejs golang composer

echo -e "${BLUE}\n\t[+] Instalando Nerd Font...${ENDCOLOR}"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip &>/dev/null
mkdir font
mv CascadiaCode.zip font/
unzip ./font/CascadiaCode.zip -d ./font/ &>/dev/null
cp ./font/CaskaydiaCoveNerdFont-Regular.ttf ~/.local/share/fonts/
rm -rf font/

echo -e "${BLUE}\n\t[+] Instalando Bottom"

curl -LO https://github.com/ClementTsang/bottom/releases/download/0.9.3/bottom_0.9.3_amd64.deb
sudo dpkg -i bottom_0.9.3_amd64.deb
rm bottom_0.9.3_amd64.deb

echo -e "${BLUE}\n\t[+] Instalando Starship"
curl -sS https://starship.rs/install.sh | sh
