_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_path() {
    fd --type f --hidden --color=always --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
    local command=$1
    shift
    case "$command" in
        cd)           fzf --preview 'eza -T --color=always --icons=always {} | head -200' "$@" ;;
        export|unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
        ssh)          fzf --preview 'doggo {}' "$@" ;;
        *)
            if [[ -f /etc/arch-release ]]; then
                fzf --preview 'bat -n --color=always {}' "$@"
            else
                fzf --preview 'batcat -n --color=always {}' "$@"
            fi
        ;;
    esac
}
