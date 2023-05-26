#!/bin/bash

set -Eeuo pipefail

trap cleanup SIGINT SIGTERM ERR EXIT
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

CYAN='\033[0;36m'
BLUE='\033[0;34m'
RED='\033[0;31m'
ENDCOLOR='\033[0m'

cleanup() {
  echo -e "\n${RED}Instalacion interrumpida. Eliminando archivos.\n"
  trap - SIGINT SIGTERM ERR EXIT
  rm -rf ~/Downloads/Relax-Plasma-Themes/
  rm -rf ~/.config/kitty/
  rm -rf ~/.config/Kvantum/
  rm -f ~/.zshrc
}

mkdir -p ~/.config/kitty

git clone https://github.com/linuxscoop/Relax-Plasma-Themes.git ~/Downloads/Relax-Plasma-Themes

mkdir -p ~/.local/share/color-schemes && cp -Rv ~/Downloads/Relax-Plasma-Themes/Relax\ Colorschemes/*.colors ~/.local/share/color-schemes/
mkdir -p ~/.themes && cp -Rv ~/Downloads/Relax-Plasma-Themes/Relax\ GTK\ Themes/* ~/.themes/
mkdir -p ~/.local/share/plasma/desktoptheme && cp -Rv ~/Downloads/Relax-Plasma-Themes/Relax\ Plasma\ Themes/ ~/.local/share/plasma/desktoptheme/
mkdir -p ~/.local/share/aurorae/themes && cp -Rv ~/Downloads/Relax-Plasma-Themes/Relax\ Window\ Decotations/* ~/.local/share/aurorae/themes/
mkdir -p ~/.config/Kvantum && cp -Rv ~/Downloads/Relax-Plasma-Themes/Relax\ Kvantum\ Themes/* ~/.config/Kvantum/

rm -rf ~/Downloads/Relax-Plasma-Themes/

rm -f ~/.zshrc
rm -f ~/.config/kitty/kitty.conf

ln -s ${script_dir}/kitty.conf ~/.config/kitty/kitty.conf
ln -s ${script_dir}/zshrc ~/.zshrc
