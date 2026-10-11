settarget() {
  echo "$1" > ~/.target_ip
  export ip="$1"
  echo "[+] Target set: $1"
}

cleartarget() { rm -f ~/.target_ip; unset ip; }

alias cip='tr -d "\n" < ~/.target_ip | copy && echo "[+] Copied $(cat ~/.target_ip)"'

[ -f ~/.target_ip ] && export ip="$(cat ~/.target_ip)"

