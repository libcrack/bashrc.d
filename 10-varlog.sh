#!/usr/bin/env bash
# Author: devnull@libcrack.so
# Date: jue may 12 03:33:19 CEST 2016
# Description: /var/log/ helpers
#
###=============================================================================
### VarLog
###=============================================================================
#
# all (read archive reset)
# auth 
# daemon (start stop restart check)
# messages 
#
# ------------------------------------------------------------------------------
# varlog daemon='sudo tail -n 100 -f /var/log/daemon.log | ccze -A'
# varlog messages='sudo tail -n 100 -f /var/log/daemon.log | ccze -A'
###=============================================================================

export X='\e[0m'
export B='\e[1m'
export R='\e[0;31m'
export G='\e[0;32m'
export Y='\e[0;33m'

varlog(){

    [[ $UID -ne 0 ]] && {
        printf "${R}Got r00t?${X}\n"
        return $UID
    }

    case $1 in
        auth)    [[ -z "$2" ]] && printf "Usage: ${FUNCNAME} auth ${Y}<reset|show|tail>${X}\n" && return 1 ;;
        daemon)  [[ -z "$2" ]] && printf "Usage: ${FUNCNAME} daemon ${Y}<reset|show|tail>${X}\n" && return 1 ;;        
        messages) [[ -z "$2" ]] && printf "Usage: ${FUNCNAME} messages ${Y}<reset|show|tail>${X}\n" && return 1 ;;
        all) case "$2" in
                 aaa) echo "AAA\n" ;;
                 bbb) echo "BBB\n" ;;
                 ccc) echo "CCC\n" ;;
                 *|help) echo "Usage: ${FUNCNAME} $1 ${Y}<aaa|bbb|ccc>${X}\n" ;;
             esac
        ;;
       *) echo "Usage: ${FUNCNAME} ${Y}<all|auth|daemon|messages>${X}\n" ;;
    esac
}

_complete_varlog(){
    COMPREPLY=()
    local cur prev opts word
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="all auth daemon messages"

    if [[ "${prev}" == "all" ]]; then
        opts="read archive reset"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}))
        return 0        
    elif [[ "${prev}" == "daemon" ]]; then
        opts="start stop restart check"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}))
        return 0
    fi

    if [[ "${cur}" == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )

}

complete -F _complete_varlog varlog
