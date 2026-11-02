if [ -f /etc/arch-release ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    fd() { fdfind "$@" ; }
    bat() { batcat "$@" ; }
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Source here to keep config clean
source "$HOME/Code/repos/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
