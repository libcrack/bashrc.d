
irsii-tor() {
    local port=6667
    local s5port=9050
    local onion_site='ftwircdwyhghzw4i.onion'
    echo socat -v "TCP4-LISTEN:${port},fork" "SOCKS4A:localhost:${onion_site}:${port},socksport=${s5port}"
}

socat-tor() {
  local s5port=9050
  local rport=80
  local lport=3333
  local lhost=127.0.0.1
  local site=1.1.1.5
  echo socat -v "TCP4-LISTEN:${lport},fork" SOCKS4a:localhost:${site}:${rport},socksport=${s5port}
}
