export XDG_CACHE_HOME="$HOME/.cache"

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export BAT_THEME="ansi"
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.local/share/go/bin:$HOME/.local/share/shitty-ctftools/bin:$HOME/.local/share/nvim/mason/bin:$HOME/.ghcup/bin/"

export DIRS='/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt'
export DIRS_SMALL='/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt'
export DIRS_COMMON='/usr/share/seclists/Discovery/Web-Content/common.txt'
export FILES='/usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt'
export SUBDOMAINS='/usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt'
export API_ENDPOINTS='/usr/share/seclists/Discovery/Web-Content/common-api-endpoints-mazen160.txt'
export ROCKYOU='/usr/share/seclists/Passwords/Leaked-Databases/rockyou.txt'
export USERNAMES='/usr/share/seclists/Usernames/xato-net-10-million-usernames.txt'
export METHODS='/usr/share/seclists/Fuzzing/http-request-methods.txt'
export WEB_EXTENSIONS='/usr/share/seclists/Discovery/Web-Content/web-extensions.txt'
export PARAMETERS='/usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt'
export DEFAULT_CREDS="$HOME/Documents/Wordlists/default-creds.txt"

export VISUAL=vim
export EDITOR="$VISUAL"

export FZF_DEFAULT_OPTS="--bind tab:down,shift-tab:up --height 40% --color=gutter:-1,prompt:-1,pointer:cyan,bg+:#393f4a --ansi"
export FZF_CTRL_T_COMMAND="fd . -H -E '.git' --type f --color=always"
export FZF_COMPLETION_TRIGGER=''

export ZLS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=00;33:so=01;35:do=01;35:bd=00;33;01:cd=00;33;01:or=00;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:';

if uname -r | grep -q "microsoft"; then
    export BROWSER='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
fi


zmodload zsh/complist

autoload -Uz compinit; compinit

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
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache" # Cache file location

zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d :3 --%f' # Format for completion category
zstyle ':completion:*:warnings' format '%F{red}-- No matches found :c --%f' # Format for when no match
zstyle ':completion:*:default' list-colors ${(s.:.)ZLS_COLORS} "ma=38;5;253;48;5;23" # Colorize suggestions
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

source "$ZDOTDIR/config.d/arch-debian.zsh"
source "$ZDOTDIR/config.d/highlights.zsh"
source "$ZDOTDIR/config.d/man.zsh"
source "$ZDOTDIR/config.d/fzf.zsh"
source "$ZDOTDIR/config.d/aliases.zsh"

source <(fzf --zsh)

bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

[[ -n "$WT_SESSION" ]] && {
  chpwd() {
    echo -en '\e]9;9;"'
    wslpath -w "$PWD" | tr -d '\n'
    echo -en '"\x07'
  }
}


eval "$(starship init zsh)"
