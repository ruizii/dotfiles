if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -U path PATH

export XDG_CACHE_HOME="$HOME/.cache"
export VISUAL=vim
export EDITOR="$VISUAL"
export BLOODHOUND_PORT=8888
export BAT_THEME="ansi"

# History not exported. Kept out of $ZDOTDIR, which is a symlink into the dotfiles repo
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000

# Wordlists
export DIRS='/usr/share/seclists/Discovery/Web-Content/raft-large-directories.txt'
export COMMON='/usr/share/seclists/Discovery/Web-Content/common.txt'
export SUBDOMAINS='/usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt'
export API_ENDPOINTS='/usr/share/seclists/Discovery/Web-Content/api/api-endpoints-res.txt'
export ROCKYOU='/usr/share/seclists/Passwords/Leaked-Databases/rockyou.txt'
export USERNAMES='/usr/share/seclists/Usernames/xato-net-10-million-usernames.txt'
export METHODS='/usr/share/seclists/Fuzzing/http-request-methods.txt'
export WEB_EXTENSIONS='/usr/share/seclists/Discovery/Web-Content/web-extensions.txt'
export PARAMETERS='/usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt'
export FASTTRACK='/usr/share/wordlists/fasttrack.txt'

# Path
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.local/share/go/bin:$PATH:$HOME/.cargo/bin:$HOME/.local/share/ctftools/bin:$HOME/.local/share/nvim/mason/bin:$HOME/.opencode/bin"

# Autosuggestions Config
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(valid_history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=60
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

[[ $(</proc/version 2>/dev/null) == *[Mm]icrosoft* ]] && is_wsl=1

(( is_wsl )) && export BROWSER='/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe'

[[ -f "$HOME/.env" ]] && source "$HOME/.env"
[[ -f "$HOME/.local_alias" ]] && source "$HOME/.local_alias"

setopt EXTENDED_GLOB
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt numericglobsort
setopt interactive_comments
setopt promptsubst

eval "$(atuin init zsh --disable-up-arrow)"

zmodload zsh/complist

fpath=(~/Code/repos/zsh-completions $fpath)

autoload -Uz compinit
# The full compinit (with its compaudit security check, ~13ms) only runs when a
# completion folder changed since the dump was built; otherwise the dump is loaded as is
() {
  local dump="$XDG_CACHE_HOME/zsh/zcompdump" d changed=0
  [[ -d ${dump:h} ]] || mkdir -p ${dump:h}
  for d in $fpath; do [[ $d -nt $dump ]] && { changed=1; break }; done
  if [[ -f $dump ]] && (( ! changed )); then
    compinit -C -d $dump 2>/dev/null
    (( $+_comp_assocs )) && return   # set by the dump's last line, so it loaded fully
    : >| $dump                       # broken or cut-off dump: empty it so it's rebuilt
  fi
  compinit -d $dump && touch $dump
}

export ZLS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=00;33:so=01;35:do=01;35:bd=00;33;01:cd=00;33;01:or=00;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:.7z=01;31:.ace=01;31:.alz=01;31:.apk=01;31:.arc=01;31:.arj=01;31:.bz=01;31:.bz2=01;31:.cab=01;31:.cpio=01;31:.crate=01;31:.deb=01;31:.drpm=01;31:.dwm=01;31:.dz=01;31:.ear=01;31:.egg=01;31:.esd=01;31:.gz=01;31:.jar=01;31:.lha=01;31:.lrz=01;31:.lz=01;31:.lz4=01;31:.lzh=01;31:.lzma=01;31:.lzo=01;31:.pyz=01;31:.rar=01;31:.rpm=01;31:.rz=01;31:.sar=01;31:.swm=01;31:.t7z=01;31:.tar=01;31:.taz=01;31:.tbz=01;31:.tbz2=01;31:.tgz=01;31:.tlz=01;31:.txz=01;31:.tz=01;31:.tzo=01;31:.tzst=01;31:.udeb=01;31:.war=01;31:.whl=01;31:.wim=01;31:.xz=01;31:.z=01;31:.zip=01;31:.zoo=01;31:.zst=01;31:.avif=01;35:.jpg=01;35:.jpeg=01;35:.mjpg=01;35:.mjpeg=01;35:.gif=01;35:.bmp=01;35:.pbm=01;35:.pgm=01;35:.ppm=01;35:.tga=01;35:.xbm=01;35:.xpm=01;35:.tif=01;35:.tiff=01;35:.png=01;35:.svg=01;35:.svgz=01;35:.mng=01;35:.pcx=01;35:.mov=01;35:.mpg=01;35:.mpeg=01;35:.m2v=01;35:.mkv=01;35:.webm=01;35:.webp=01;35:.ogm=01;35:.mp4=01;35:.m4v=01;35:.mp4v=01;35:.vob=01;35:.qt=01;35:.nuv=01;35:.wmv=01;35:.asf=01;35:.rm=01;35:.rmvb=01;35:.flc=01;35:.avi=01;35:.fli=01;35:.flv=01;35:.gl=01;35:.dl=01;35:.xcf=01;35:.xwd=01;35:.yuv=01;35:.cgm=01;35:.emf=01;35:.ogv=01;35:.ogx=01;35:.aac=00;36:.au=00;36:.flac=00;36:.m4a=00;36:.mid=00;36:.midi=00;36:.mka=00;36:.mp3=00;36:.mpc=00;36:.ogg=00;36:.ra=00;36:.wav=00;36:.oga=00;36:.opus=00;36:.spx=00;36:.xspf=00;36:~=00;90:#=00;90:.bak=00;90:.crdownload=00;90:.dpkg-dist=00;90:.dpkg-new=00;90:.dpkg-old=00;90:.dpkg-tmp=00;90:.old=00;90:.orig=00;90:.part=00;90:.rej=00;90:.rpmnew=00;90:.rpmorig=00;90:.rpmsave=00;90:.swp=00;90:.tmp=00;90:.ucf-dist=00;90:.ucf-new=00;90:.ucf-old=00;90:';

WORDCHARS=${WORDCHARS/\/}
WORDCHARS=${WORDCHARS/_}

# Completion Styles
zstyle ':completion:*' menu select yes=long select=long-list # Enable menu; open it straight away if the list doesn't fit
zstyle ':completion:*' rehash true # Update changes in path automatically
zstyle ':completion:*' verbose true # Verbose
zstyle ':completion:*' group-name '' # Separate suggestions into their respective categories
zstyle ':completion:*' list-dirs-first true # Directories first
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on # Cache for speed
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache" # Cache file location
zstyle ':completion:*:descriptions' format '%F{blue}-- %d :3 --%f'
zstyle ':completion:*:warnings' format '%F{red}-- No matches found :c --%f'
zstyle ':completion:*:default' list-colors ${(s.:.)ZLS_COLORS} "ma=38;5;253;48;5;23"
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' '+r:|[._-]=* r:|=*' '+l:|=* r:|=*'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' select-prompt '%SScrolling: %p%s'

# Fish-style descriptions: "--all  (do not ignore)" instead of "--all  -- do not ignore".
# Rewrites the display array that _describe (-d name) and _git (-ld name) pass to compadd,
# and colours the text yellow only in the groups it rewrote (not e.g. "(sd-pam)" in kill).
compadd() {
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  local -i _fd_i _fd_j _fd_changed; local _fd_arr _fd_grp _fd_next; local -a _fd_d
  for (( _fd_i = 1; _fd_i < $#; _fd_i++ )); do
    _fd_next=$@[_fd_i+1]
    case $@[_fd_i] in
      (-|--) break ;;                                    # the rest are matches, not options
      (-[a-zA-Z0-9]#[JV]) _fd_grp=$_fd_next ;;           # group name
      (-[a-zA-Z0-9]#d) [[ ${(Pt)_fd_next} == array* ]] && _fd_arr=$_fd_next ;;
    esac
  done
  if [[ -n $_fd_arr ]]; then
    _fd_d=("${(@P)_fd_arr}")
    for (( _fd_j = 1; _fd_j <= $#_fd_d; _fd_j++ )); do
      case $_fd_d[_fd_j] in
        # Grouped options (-a --all) list the description as its own padded entry
        ('-- '*) [[ $_fd_d[_fd_j] == (#b)--\ (*[^ ])( #) ]] || continue
                 _fd_d[_fd_j]="(${match[1]})${match[2]} " ;;
        (*' -- '*) _fd_d[_fd_j]=${_fd_d[_fd_j]/(#b) -- (*)/ (${match[1]})} ;;
        (*) continue ;;
      esac
      _fd_changed=1
    done
    if (( _fd_changed )); then
      set -A $_fd_arr "${_fd_d[@]}"
      [[ -n $_fd_grp ]] && (( $+_comp_colors )) &&
        _comp_colors+=("($_fd_grp)=(#b)(|[^\(]# )(\()(*)(\))( #)=0=0=0=3;33=0=0")   # 3;33 = italic yellow
    fi
  fi
  builtin compadd "$@"
}

# Processes completion
zstyle ':completion:*:processes' force-list always
zstyle ':completion:*:processes' menu select
zstyle ':completion:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:processes' command "ps -u $USER -o pid,user,args -w -w"

bindkey -e
# Esc only hides a completion list left on screen (like fish), otherwise does nothing
_esc_hide_list() { zle -R -c }
zle -N _esc_hide_list
bindkey '^[' _esc_hide_list
bindkey -M menuselect '^[' undo # Esc cancels completion menu
bindkey "^[[3~" delete-char
bindkey "^[[Z" reverse-menu-complete

# 20ms
KEYTIMEOUT=2

source "$HOME/Code/repos/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

source "$ZDOTDIR/config.d/aliases.zsh"
source "$ZDOTDIR/config.d/autosuggest.zsh"
source "$ZDOTDIR/config.d/highlights.zsh"
source "$ZDOTDIR/config.d/htb.zsh"

[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh   # Arch
[[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh                           # Debian

# Wrapper functions to make bat and fd available on Distros with batcat and fdfind instead of bat and fd
(( $+commands[batcat] && ! $+commands[bat] )) && bat() { batcat "$@" }
(( $+commands[fdfind] && ! $+commands[fd] )) && fd() { fdfind "$@" }

# History lists all entries with timestamps
history() { builtin history -i "${@:-0}" }

# Colorful man pages
man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;36m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    GROFF_NO_SGR=1 \
    man "$@"
}

# Make completion menu smaller
_complete_small() {
  local -i real=$LINES max=30
  (( LINES = real < max ? real : max ))
  zle expand-or-complete
  (( LINES == max )) && LINES=$real    # unless the terminal was resized meanwhile
  zle reset-prompt                     # redraw at the real size
}
zle -N _complete_small
bindkey '^I' _complete_small

[[ -n "$WT_SESSION" ]] && {
  _wt_prompt() {
    # Only run wslpath when the directory changed since the last prompt
    if [[ $PWD != $_wt_last_pwd ]]; then
      _wt_last_pwd=$PWD
      printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
    fi
    printf '\033[5 q'
  }

  precmd_functions+=(_wt_prompt)
}

source "$HOME/Code/repos/powerlevel10k/powerlevel10k.zsh-theme"

# To customize prompt, run p10k configure or edit $ZDOTDIR/.p10k.zsh.
[[ ! -f "$ZDOTDIR/.p10k.zsh" ]] || source "$ZDOTDIR/.p10k.zsh"
