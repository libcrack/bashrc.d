# Author: devnull@libcrack.so
# Date: Sat Jan 10 11:26:32 CET 2015
# Description: Coredump activation helper function

export X='\e[0m'
export B='\e[1m'
export R='\e[0;31m'
export G='\e[0;32m'

_coredumpctl_enable_cores(){

    [[ $UID -ne 0 ]] && {
        error "Got r00t?"
        return $UID
    }

    ## /var/core/
    local coredir="/var/core"
    local pattern="%e.pid%p.sig%s.%t.core"

    [[ -n "$VARCORE" ]] && pattern="${coredir}/%e.pid%p.sig%s.%t.core"

    ## $PWD/app.core
    test -z "$1" || pattern="$1"

    echo -e "[*] Old core pattern: ${R}$(cat /proc/sys/kernel/core_pattern)${X}"
    echo -e "[*] New core pattern: ${G}${pattern}${X}"
    # echo "$pattern" > /proc/sys/kernel/core_pattern
    sysctl -w kernel.core_pattern="$pattern" > /dev/null

    echo -e "[*] Enabling suid core dumps"
    sysctl -w kernel.suid_dumpable=1
    sysctl -w kernel.core_uses_pid=1

    echo -e "[*] Setting coredump limit to ${B}unlimited${X}"
    ulimit -c unlimited
    return $?
}

coredumpctl_enable(){
    case "$1" in
        31337) echo "easter egg ..." ;;
        hax0r) echo "another easter egg" ;;
        *) _coredumpctl_enable_cores ;;
    esac
}
