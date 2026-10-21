settarget() {
  echo "$1" > ~/.target_ip
  export ip="$1"
  echo "[+] Target set: $1"
}

cleartarget() { rm -f ~/.target_ip; unset ip; }

[ -f ~/.target_ip ] && export ip="$(cat ~/.target_ip)"

