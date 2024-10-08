if [ -f /etc/arch-release ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export FZF_DEFAULT_COMMAND="fd . -H -E '.git' --type f --color=always"
    export FZF_ALT_C_COMMAND="fd . -H --type d --color=always"
else
	fd() { fdfind "$@" ; } ;
	bat() { batcat "$@" ; } ;
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    export FZF_DEFAULT_COMMAND="fdfind . -H -E '.git' --type f --color=always"
    export FZF_ALT_C_COMMAND="fdfind . -H --type d --color=always"
fi
