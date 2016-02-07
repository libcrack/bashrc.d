# Firejail helper (Linux advanced sandbox using different methos)
# https://firejail.wordpress.com/

firejailctl(){
    local git_repo="https://github.com/netblue30/firejailctl"
    local debian_firejail="http://sourceforge.net/projects/firejail/files/firejail/firejail_0.9.38_1_amd64.deb"
    local debian_firetools="http://sourceforge.net/projects/firejail/files/firetools/firetools_0.9.30_1_amd64.deb"
    which firejail > /dev/null || {
        error "You need firejail installed"
        error "Grab the sofware from:"
        error "$git_repo"
        error "$debian_firejail"
        error "$debian_firetools"
        return
    }
    case "$1" in
        start)   firejail "$1" & ;;
        status)  firejail --tree | ccze -A ;;
        monitor) firemon ;;
        list)    firejail --list ;;
        tree)    firejail --tree ;;
        caps)    firejail --caps "$2" & ;;
        tmp)     firejail --private "$2" & ;;
        seccomp) firejail --seccomp "$2" & ;;
        firefox) firejail firefox --new-instance & ;;
        chroot)  firejail --chroot="$2" --name="$3" & ;;
        *) echo "Usage: $FUNC_NAME <start|status|monitor|list|tree|caps|tmp|seccomp|firefox|chroot> <binary>" ;;
    esac
}
_complete_firejailctl(){
    COMPREPLY=()
    local cur prev opts word
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="start status monitor list tree caps tmp seccomp firefox chroot"

#    if [[  "${prev}" == "tmp"  \
#        || "${prev}" == "caps" \
#        || "${prev}" == "seccomp" ]]; then
#        opts="${PWD}/*"
#        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}))
#        return 0
#    fi

    if [[ "${cur}" == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )

}
complete -F _complete_firejailctl firejailctl
