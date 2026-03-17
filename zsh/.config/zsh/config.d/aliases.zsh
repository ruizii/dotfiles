if [[ -r /proc/version ]] && [[ $(</proc/version) == *icrosoft* ]]; then
    alias copy='/mnt/c/Windows/System32/clip.exe'
elif [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    alias copy='xclip -selection clipboard'
else
    alias copy='wl-copy'
fi
alias ls='eza --icons always'
alias history='history -i 0'
alias icat='kitty +kitten icat'
alias ip='ip --color=auto'
alias diff='difft'
alias glow='glow -p'
alias nc='ncat'
alias generate-leetspeak='hashcat --force --stdout -r /usr/share/hashcat/rules/leetspeak.rule'
alias generate-permutations='hashcat --force --stdout -r /usr/share/hashcat/rules/leetspeak.rule -r /usr/share/hashcat/rules/top10_2025.rule'
alias fping='fping -agq'
alias ssh='TERM=xterm-256color ssh'
alias curl='curlie -v'
alias nvconfig="cd $HOME/.config/nvim && nvim"
alias zshconfig="cd $ZDOTDIR && nvim"
alias gdb='gdb -q'
alias less='bat'
alias cat='bat -pp'
alias grep='grep --color=auto'
