# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
todo

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

fpath=("${ZDOTDIR}/functions" $fpath)

# Custom functions
autoload -Uz "${ZDOTDIR}/functions/scan"
autoload -Uz "${ZDOTDIR}/functions/timezsh"
autoload -Uz "${ZDOTDIR}/functions/man"

zmodload zsh/complist

# Load compinit once a day
autoload -Uz compinit
for dump in "${ZDOTDIR}/.zcompdump(N.mh+24)"; do
  compinit
done

setopt numericglobsort     # sort filenames numerically when it makes sense
setopt interactive_comments
setopt promptsubst         # enable command substitution in prompt
setopt SHARE_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it

WORDCHARS=${WORDCHARS/\/} # Forward slash as word separator
WORDCHARS=${WORDCHARS/_} # Underscore as word separator

# enable completion features
zstyle ':completion:*' menu select # Enable menu
zstyle ':completion:*' rehash true # Update changes in path automatically
zstyle ':completion:*' verbose true # Verbose
zstyle ':completion:*' group-name '' # Separate suggestions into their respective categories
zstyle ':completion:*' list-dirs-first true # Directories first
zstyle ':completion:*' completer _complete
zstyle ':completion:*' use-cache on # Cache for speed
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache" # Cache file location

zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d :3 --%f' # Format for completion category
zstyle ':completion:*:warnings' format '%F{red}-- No matches found --%f' # Format for when no match
zstyle ':completion:*:default' list-colors ${(s.:.)ZLS_COLORS} # Colorize suggestions
zstyle ':completion:*' squeeze-slashes true # // = /
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s # Message for when paging
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion::complete:*' gain-privileges 1 # Completions in sudo

# Prettier completion for processes
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' menu select
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w -w"

zmodload zsh/complist
bindkey -e
bindkey -s '^[' ''
bindkey -M menuselect '^[' undo # Esc cancels completion menu
bindkey "^[[3~" delete-char
bindkey "^[[Z" reverse-menu-complete
bindkey "^[^?" backward-delete-char

KEYTIMEOUT=10 # For speeding up esc menu completion cancelation

alias history="history 0"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=blue
ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green
ZSH_HIGHLIGHT_STYLES[path]=bold
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[comment]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# alias cat='bat -pp'
alias ls='eza -g --icons always'
alias grep='rg'
alias cat='bat -pp'
alias icat='kitty +kitten icat'
alias ip='ip --color=auto'
alias ftp='lftp'
alias glow='glow -p'
alias leetcode='nvim leetcode.nvim'
alias upc='cd /run/media/drive/upc/'
alias updog='sudo updog -p 80'
alias testc='mkdir -p ~/test && cd ~/test && touch main.c && mkfl'
alias rmtest='cd ~ && rm -rf ./test/'
alias szsh='source ~/.config/zsh/.zshrc'
alias backup-config='rsync -avPh /home/asdf/.config /run/media/asdf/New\ Volume/Backup/'

# fzf
export FZF_DEFAULT_COMMAND="fd . -H -E '.git' --type f --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd . -H -t d --color=always"
export FZF_DEFAULT_OPTS="--height 40% --color=gutter:-1,prompt:-1,pointer:cyan,bg+:#393f4a --ansi"
export FZF_COMPLETION_TRIGGER=''

source <(fzf --zsh)

bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

# Configuring fuzzy completion
_fzf_compgen_path() {
  fd --type f --hidden --color=always --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza -T {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# powerline10k
source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh