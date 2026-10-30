# Fish-style history autosuggestions.
#
# Like fish, a history entry is only suggested when:
#   - for cd/pushd: the target is a directory from here, and not the current one
#   - otherwise: the command still exists, and every argument that was a real
#     file or directory when you ran it still exists from the current directory
#
# Path arguments are recorded when you press Enter and stored in a side file,
# since zsh history doesn't keep that information.

zmodload zsh/system zsh/stat 2>/dev/null
autoload -Uz add-zsh-hook

typeset -g  _zas_file=${_zas_file:-${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history_paths}
typeset -gA _zas_paths   # normalized command -> NUL-separated required paths
typeset -gi _zas_offset=0

# Normalize a command line so it matches regardless of extra whitespace
# (HIST_REDUCE_BLANKS changes what's stored in history)
_zas_key() { emulate -L zsh; REPLY=${(j: :)${(z)1}} }

# Keep the longer list of required paths, like fish's history merge
_zas_merge() {
  local key=$1; shift
  local -a old=(${(ps:\0:)_zas_paths[$key]})
  (( $# >= $#old )) && _zas_paths[$key]=${(pj:\0:)@}
}

# Read entries appended to the side file since the last read
_zas_sync() {
  emulate -L zsh
  [[ -r $_zas_file ]] || return 0
  local -a st; zstat -A st +size -- $_zas_file 2>/dev/null || return 0
  local -i size=$st[1]
  (( size == _zas_offset )) && return 0
  (( size < _zas_offset )) && { _zas_paths=(); _zas_offset=0 }   # file was compacted

  local fd chunk data
  exec {fd}<$_zas_file || return 0
  sysseek -u $fd $_zas_offset
  while sysread -i $fd chunk; do data+=$chunk; done
  exec {fd}<&-
  _zas_offset=size

  local line; local -a f
  for line in ${(f)data}; do
    f=("${(@Q)${(z)line}}")
    (( $#f >= 2 )) && _zas_merge "$f[1]" "${(@)f[2,-1]}"
  done
}

# zshaddhistory hook: record which arguments are real paths right now
_zas_record() {
  emulate -L zsh
  setopt EXTENDED_GLOB
  local line=${1%$'\n'}
  [[ $line == ' '* ]] && return 0   # HIST_IGNORE_SPACE commands stay private

  local -a words=(${(z)line}) found
  local w p expect_cmd=1 skip_next=0
  for w in $words; do
    if (( skip_next )); then skip_next=0; continue; fi
    case $w in
      (\;|\||\|\||\&\&|\&|\|\&|\&\||\&!) expect_cmd=1; continue ;;     # separators
      ([0-9]#(\<|\>)*|\&\>*) skip_next=1; continue ;;                   # redirections
    esac
    if (( expect_cmd )); then
      [[ $w == [[:alnum:]_]##=* ]] || expect_cmd=0                    # VAR=x prefixes
      continue
    fi
    [[ -z $w || $w == -* || $w == *[\$\`*?\[]* ]] && continue
    p=${(Q)w}; p=${p/#\~/$HOME}
    [[ -e $p ]] && found+=($p)
  done
  (( $#found )) || return 0

  _zas_key "$line"
  _zas_merge "$REPLY" "${(@)found}"
  [[ -d ${_zas_file:h} ]] || mkdir -p ${_zas_file:h}
  print -r -- "${(q+)REPLY}" "${(@q+)found}" >> $_zas_file
  return 0
}

# Fish's autosuggest_validate_from_history
_zas_valid() {
  emulate -L zsh
  setopt EXTENDED_GLOB
  local -a words=(${(z)1})
  local -i i=1
  while [[ $words[i] == [[:alnum:]_]##=* ]]; do (( i++ )); done
  local cmd=${(Q)words[i]}
  [[ -z $cmd ]] && return 0

  if [[ $cmd == (cd|pushd) && -n $words[i+1] ]]; then
    local d=$words[i+1] t c
    [[ $d == -* || $d == *[\$\`]* ]] && return 0   # options and variables
    d=${(Q)d}; d=${d/#\~/$HOME}
    if [[ $d == /* ]]; then
      t=$d
    else
      for c in . $cdpath; do [[ -d $c/$d ]] && { t=$c/$d; break }; done
    fi
    [[ -n $t && -d $t && ${t:A} != ${PWD:A} ]]
    return
  fi

  if [[ $cmd == */* ]]; then
    [[ -x ${cmd/#\~/$HOME} ]] || return 1
  elif (( ! ( $+commands[$cmd] || $+functions[$cmd] || $+builtins[$cmd] \
              || $+aliases[$cmd] || ${reswords[(Ie)$cmd]} ) )); then
    return 1
  fi

  _zas_key "$1"
  local p
  for p in ${(ps:\0:)_zas_paths[$REPLY]}; do [[ -e $p ]] || return 1; done
  return 0
}

_zsh_autosuggest_strategy_valid_history() {
  emulate -L zsh
  setopt EXTENDED_GLOB

  # Same prefix escaping and ignore pattern as the built-in history strategy
  local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}"
  local pattern="$prefix*"
  [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]] && pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)"

  # Newest matches first, checking at most 50
  local -a keys=(${(On)${(k)history[(R)$pattern]}})
  local k
  for k in $keys[1,50]; do
    if _zas_valid "$history[$k]"; then
      typeset -g suggestion="$history[$k]"
      return
    fi
  done
}

# Load recorded paths, compacting the file when it has many stale duplicates
_zas_sync
if [[ -f $_zas_file ]] && (( ${#${(f)"$(<$_zas_file)"}} > 2 * $#_zas_paths + 200 )); then
  local _k
  {
    for _k in ${(k)_zas_paths}; do
      print -r -- "${(q+)_k}" "${(@q+)${(ps:\0:)_zas_paths[$_k]}}"
    done
  } > $_zas_file.$$ && mv -f $_zas_file.$$ $_zas_file
  _zas_offset=0; _zas_paths=(); _zas_sync
  unset _k
fi

add-zsh-hook zshaddhistory _zas_record
add-zsh-hook precmd _zas_sync
