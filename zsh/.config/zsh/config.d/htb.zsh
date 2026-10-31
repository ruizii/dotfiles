settarget() {
  echo "$1" > ~/.target_ip
  export ip="$1"
  echo "[+] Target set: $1"
}

cleartarget() { rm -f ~/.target_ip; unset ip; }

# Pick up settarget/cleartarget from other tabs. Only touches $ip when the
# file changed, so a manual `export ip=...` sticks until the next settarget.
_htb_sync_target() {
  local t; [[ -r ~/.target_ip ]] && t=$(<~/.target_ip)
  [[ $t == $_htb_last_target ]] && return
  _htb_last_target=$t
  if [[ -n $t ]]; then export ip=$t; else unset ip; fi
}
_htb_sync_target
precmd_functions+=(_htb_sync_target)

# Powerlevel10k segment, listed in POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS
prompt_htb_target() { [[ -n $ip ]] && p10k segment -f red -i '󰓾' -t "${ip//\%/%%}" }
instant_prompt_htb_target() { prompt_htb_target }

