# Jose Miguel de la Casa - Chemi, [28.10.15 16:24]

# apt-history (Z_system_apt-history){{{
function Z_system_apt-history(){
    [[ "$(lsb_release -s -i)" == "Debian" ]] || {
        error "$FUNCNAME: This is not a Debian box"
        return 1
    }
    case "$1" in
        install) cat /var/log/dpkg.log | grep 'install ' ;;
        upgrade|remove) cat /var/log/dpkg.log | grep "$1" ;;
        rollback) cat /var/log/dpkg.log | grep upgrade \
                   | grep "$2" -A10000000 | grep "$3" -B10000000 \
                   | awk '{print $4"="$5}' ;;
        *) cat /var/log/dpkg.log ;;
    esac
}
# }}}

# Locate fields in web forms (Z_util_formfind) {{{
function Z_util_formfind (){
    AGENT="None"
    if [ -n "$(which curl)" ];then AGENT="$(which curl) -o";
    elif [ -n "$(which wget)" ];then AGENT="$(which wget) -O";
    elif [ "$AGENT" == "None" ];then error "please, install wget or curl. Exiting";
    elif [ -n "$1" ] ; then
       NAME="$(mktemp)"
       $AGENT $NAME "$1"
       echo "~/workspace/bitbucket.org/zvim/utils/formfind < $NAME"
       ~/workspace/bitbucket.org/zvim/utils/formfind < $NAME
       echo "=========================================================="
    else
        echo "please, need a url"
    fi
}
# }}}

# Color Chart {{{
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset
# }}}

# Sysadmin utils {{{
alias Z_admin_inicio_de_proc='ps -eo pid,lstart,cmd'
alias Z_admin_commandlinefu='lynx http://www.commandlinefu.com/'
alias Z_util_wiki='wikipedia2text -p '
alias Z_admin_creaserverweb='python -m SimpleHTTPServer'
alias Z_admin_sshcopyidchemi='cat ~/.ssh/id_rsa.pub | ssh user@machine "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys"'
alias Z_admin_cualesmiip='dig @208.67.222.222 myip.opendns.com'
alias Z_admin_allproccess="cd /proc&&ps a -opid=|xargs -I+ sh -c '[[ $PPID -ne + ]]&&echo -e \"\n[+]\"&&tr -s \"\000\" \" \"<+/cmdline&&echo&&tr -s \"\000\033\" \"\nE\"<+/environ|sort'"
alias Z_admin_teclado='setxkbmap es'
alias Z_admin_backdoor='nc -l -p 2000 -e /bin/bash'
alias Z_admin_sincronizassh="rsync -aHSvz --rsh='ssh -p 22' --numeric-ids"
alias Z_admin_reversetunnel="ssh -p 6923 -L 9001:192.168.112.1:80 82.158.192.97"

# Source URL: https://github.com/comwt/bash-git
