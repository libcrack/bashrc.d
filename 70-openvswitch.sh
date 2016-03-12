# open vswitch helpers

ovs-ctl-add-port(){
    local switch='br0'
    [[ -z "$1" ]] && error "Uso: ${FUNCNAME} <iface> [bridgeif]" && return
    [[ -z "$2" ]] || switch="$2"
    /sbin/ifconfig "$1" 0.0.0.0 up
    ovs-vsctl add-port "${switch}" "$1"
}

ovs-ctl-del-port(){
    [[ -z "$1" ]] && error "Uso: ${FUNCNAME} <iface> [bridgeif]" && return
    local switch='br0'
    [[ -z "$2" ]] || switch="$2"
    /sbin/ifconfig "$1" 0.0.0.0 down
    ovs-vsctl del-port "${switch}" "$1"
}
