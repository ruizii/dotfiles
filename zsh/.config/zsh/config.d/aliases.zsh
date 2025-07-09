if uname -r | grep -q "microsoft"; then
    alias copy='/mnt/c/Windows/System32/clip.exe'
elif [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    alias copy='xclip -selection clipboard'
else
    alias copy='wl-copy'
fi
alias ls='eza --icons always'
alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
alias history='history -i 0'
alias icat='kitty +kitten icat'
alias ip='ip --color=auto'
alias glow='glow -p'
alias nc='ncat'
alias testc='mkdir -p ~/test && cd ~/test && touch main.c && mkfl.sh'
alias testgo='mkdir -p ~/test && cd ~/test && go mod init test && echo -e "package main\n" > main.go && echo -e "import \"fmt\"\n" >> main.go && echo "func main() {" >> main.go && echo -e "\tfmt.Println(\"Hello, world!\")" >> main.go && echo "}" >> main.go'
alias testasm='mkdir -p ~/test && cd ~/test && mkflasm.sh && echo "global _start" > main.asm && echo "" >> main.asm && echo "section .text" >> main.asm'
alias dockershell='docker run --rm -i -t --entrypoint=/bin/bash'
alias dockershellsh='docker run --rm -i -t --entrypoint=/bin/bash'
alias curl='curlie -v'
alias rmtest='cd ~ && rm -rf ./test/'
alias nvconfig="cd $HOME/.config/nvim && nvim"
alias zshconfig="cd $ZDOTDIR && nvim"
alias gdb='gdb -q'
alias less='bat'
alias cat='bat -pp'
alias xd='hexyl --border none'
alias grep='grep --color=auto'
