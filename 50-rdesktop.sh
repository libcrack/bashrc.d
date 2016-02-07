function remotedesktop() {
    local res="1420x840"
    local sdir=~/Shared
    local sname="Arch"
    local rdisk="disk:${sname}=${sdir}"

    [[ -z "$1" ]] || {
        local ip="$1"
        rdesktop -g "$res" -k es -r "$rdisk" "$ip"
    }
    return $?
}
alias windoze="remotedesktop windoze"
alias petalo="remotedesktop petalo"
