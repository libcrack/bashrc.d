tcpproxy() {
    [[ ${#} != 4 ]] && {
        error echo "$FUNCNAME: lhost lport rhost rport maxconn"
        error "\t$FUNCNAME 1.1.1.1 1234 2.2.2.2 1234 1000"
        exit 1
    }
    [[ $UID -ne 0 ]] && {
        error "Got r00t?"
        return $UID
    }    
    sysctl net.ipv4.ip_forward=1
    iptables -t nat -A PREROUTING --dst $1 -p tcp --dport $2 -j DNAT --to-destination $3:$4
    iptables -t nat -A POSTROUTING --dst $3 -p tcp --dport $4 -j SNAT --to-source $1
    iptables -t nat -A OUTPUT -p tcp --dport $2 -m connlimit --connlimit-above $5 -j RETURN
    iptables -t nat -A OUTPUT --dst $1 -p tcp --dport $2 -j DNAT --to-destination $3:$4
}
