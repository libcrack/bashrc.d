### libcrack@libcrack.so
### sab nov 29 15:10:27 CET 2014

### privs {{{
checkroot(){
    if [ $(id -n) -ne 0 ]; then
        echo -e "\n\t You need r00t privs to exec this script \n"
        return 2
    fi
}
### }}}


### signaling {{{
#trap captura INT
#captura(){
#        echo " Exiting ... "
#        return 1
#}
### }}}


### COLOR OUTPUT {{{
negrita(){
    echo -e "${BOLD}${1}${RESET}";
}

#msg()   { echo -e "[*]\033[1m ${1}\033[0m"; }
#msg()   { echo -e "${BOLD}[*] ${1}${RESET}"; }
msg(){
    echo -e "${BOLD}[*]${RESET} ${@}";
}

msgline(){
    echo -e "${BOLD}[*] `perl -e 'print "-"x50'`${RESET}";
}

msgbox(){
    msgline;
    echo -e "${BOLD}[*]${RESET} ${@}";
    msgline;
}

usage(){
    echo -e "${BOLD}\n\t[*] ${@}${RESET}\n";
}

success(){
    echo -e "${BOLD}${BGREEN}[✔]${RESET} ${@}";
}

error(){
    echo -e "${BOLD}${IRED}[✘]${RESET} ${@}";
}

die(){
    echo -e "\n\t${BRED}[✘✘✘] ERROR:${RESET} ${@}\n";
    return 1
    #return "$?"
    #return "$!"
}
###}}}


### ERROR HANDLING {{{
check_error(){
    if [ "$1" != "0" ]; then
        negrita "\n\t[*] ERROR\n\n";
        return 99 ;
    fi
}
###}}}


### LOGGING {{{
toLogger(){
    daemon="$1"
    msg="$2"
    logger -t "${daemon}" "${msg}"
    echo "[*] ${msg}"
}


whereIam(){

    local prg=$0

    [[ ! -e "$prg" ]] && {
      case $prg in
        (*/*) return 1;;
        (*) prg=`which "$prg"` || return;;
      esac
    }

    dir=`cd -P -- "$(dirname -- "$prg")" && pwd -P` || return
    prg=$dir/`basename -- "$prg"` || return

    printf '%s\n' "$prg"
}
###}}}


### DEBUGGING {{{
gdb_get_backtrace() {
    [[ ${#} == 2 && -f "$1" && -f "$2" ]] || {
        error "Usage: $FUNCNAME <exe> <core>"
        return
    }
    local exe=$1
    local core=$2
    gdb -q ${exe} --core ${core} --batch
        -ex "thread apply all bt full"
        -ex "quit"
}


rpath_check() {
    [[ "${#}" == 1 ]] || {
        error "Usage: $FUNCNAME <binary|directory>"
        return
    }
    [[ -f "$1" ]] && readelf -d "$1" | /bin/grep PATH
    [[ -d "$1" ]] && for i in "$1"; do readelf -d "$i" | /bin/grep PATH; done
}
###}}}


### APP LAUNCHERS {{{
gedit(){
    /usr/bin/gedit ${@} 2>/dev/null &
}

subl(){
    /usr/bin/subl ${@} 2>/dev/null &
}

subl3(){
    /usr/bin/subl3 ${@} 2>/dev/null &
}

generateMAC(){
    RND="$(dd if=/dev/urandom bs=512 count=1 2>/dev/null \
        | md5sum \
        | sed 's/^\(..\)\(..\)\(..\).*$/\1:\2:\3/')"
    MACADDR="52:54:00:$RND"
    echo $MACADDR
}
###}}}


### RANDOM STUFF {{{
randomMAC(){
    printf 'DE:AD:BE:EF:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256))
}

getHTTPparams(){
    python2 -c \
        "for i in '${1}'.split('&'): print i.split('=')[0]," \
        | tr ' ' ','
}

whatismyip(){
    dig +short myip.opendns.com @resolver1.opendns.com
}

pastebin(){
    curl -F 'sprunge=<-' http://sprunge.us
}

transfer(){
    [[ $# -eq 0 ]] && {
        error "Invalid arguments"
        echo -e "\t$FUNCNAME /tmp/test.md"
        echo -e "\tcat /tmp/test.md | $FUNCNAME test.md"
        return 1
    }
    tty -s && {
        [[ -f "$1" ]] || { error "$1 does not exists"; return 1; }
        local basefile="$(basename "${1}" | sed -e 's/[^a-zA-Z0-9._-]/-/g')"
        curl --progress-bar --upload-file "$1" "https://transfer.sh/${basefile}"
    } || curl --progress-bar --upload-file "-" "https://transfer.sh/${1}"
}

pdfcrypt(){
    [[ ${#} == 1 && -f "$1" ]] || {
        echo "Uso: $FUNCNAME <pdf> [password]"
        return 1
    }

    local in="$1"
    local passwd="$2"
    local out="${in//.pdf}-enc.pdf"

    [[ -z "$2" ]] && passwd="afd022d8f62222ebb12"

    msg "Encrypting ${out} using password ${passwd}"
    qpdf --password="" --decrypt "${in}" "${in}.$$"
    pdftk "${in}.$$" output "${out}" user_pw "${passwd}" allow AllFeatures
    rm "${in}.$$"
}
###}}}


### TTY CONSOLE {{{
screen-ttyUSB(){
    screen -t 'ttyUSB0 115200 8n1' /dev/ttyUSB0 "115200,-ixoff,-ixon"
}
tmux-USB(){
    /usr/bin/tmux -2 new-window $(which miniterm2.py) /dev/ttyUSB0 115200 \; attach;
}
###}}}


### MAC addresses look-up {{{

get-oui(){
    tmpoui="/tmp/oui.txt"
    urloui="http://standards.ieee.org/develop/regauth/oui/oui.txt"
    msg "Downloading $tmpurl ==>  $tmpoui"
    curl -s -k -L -o "$tmpoui" "$urloui" && success "$tmpoui"
}

mac-lookup(){
    if [ -z "$1" ]; then
        error "Usage: $FUNCNAME <binary|directory>"
        return 2
    fi

    local out=
    local mac="${1}"
    local mac2="${mac//:}"
    local mac_h="${x:0:8}"
    local mac_l="${x:9:17}"
    grep -i "${mac_h}" "${oui}" && success "${mac_h}"
    return $?

    # local mac="${1//:}"
    # local mac="${mac:4:18}"
    # local mac_h="${mac:9:17}"
    # local mac_l="${mac_h//:}"
    # local mac="$(ip link show | grep /ether | awk '{print $2}' | sort -u | head -1)"
    # curl -skL "$oui" 2>/dev/null | grep --color -i "$mac"
    # sed 's/:/-/g'
    # echo -n "$mac" | cut -f 4-6 -d: | tr -d ':' | tr '[a-z]' '[A-Z]'
    # halfmac=$(ip link show  awk '{ print $2 }' | cut -f 1-3 -d: | tr [a-z] [A-Z])
}

### }}}


### ARCH MAINTENANCE {{{
pacman_outdated(){
    for pkg in $(pacman -Qqu); do
        # echo "$(pacman -Si "$pkg" | grep '^Versi' | sed 's/^Versi.n\s*:\s//')"
        echo "$pkg: $(pacman -Qi "$pkg" | grep '^Versi' | sed 's/^Versi.n\s*:\s//')"
    done
}
###}}}


### TED talk downloader {{{
tedtalk()
{
    [[ -z "$1" ]]  && {
        echo -e "Usage: $FUNCNAME http://www.ted.com/talks/<talk_name>"
        return 1
    }

    local languages="es en"
    local lang=

    for lang in $languages; do
        local video_url=$(curl -s "$1" | perl -wnl -e \
            '/"'$lang'":\{.+(http:.*'$lang'.mp4).+\}/ and print $1')
        [[ ! -z "$video_url" ]] && {
            msg "Opening ${BGREEN}${video_url}${RESET}"
            "$(which vlc)" "$video_url" > /dev/null 2>&1 &
            return $!
        }
    done

    die "Not spanish nor english subtitled video found"
}
### }}}


kill-gnome(){
    ps aux | egrep 'gnome-keyring-daemon|gvfs|gpg-agent|dirmgr' \
    | grep -v grep | awk '{print $2}' | xargs kill -9
}


gravatar(){
    [[ -z "$1" ]] && {
	error "Usage: $FUNCNAME user@host - grabs user@host's gravatar"
	return 88
    }

    local email="${1}"
    local email_img="${email}-gravatar.png"
    local email_md5="$(echo -n "${email}" | md5sum - | awk '{print $1}')"
    local gravatar_url="https://www.gravatar.com/avatar/${email_md5}"
    curl -s -k -L -o "${email_img}" "${gravatar_url}" \
      && success "${email_img}" \
	  || error "Error downloading \"${email_img}\""
    return $?
}


valid_ip(){
    local ip="$1"
    local stat=1

    if [[ "$#" == 1 ]]; then
	    error "Usage: $FUNCNAME user@host - grabs user@host's gravatar"
	    return 88
    fi

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
         && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
  return $stat
}


mac-lookup(){
    local mac="${1}"
    local mac1="${mac//:}"
    local mac2="${mac:6:8}"
    local tmpoui="/tmp/oui.txt"
    # local mac="bc:5f:f4:d6:b8:ee"; mac1="${mac//:}"; mac2="${mac:6:8}"
    local urloui="http://standards.ieee.org/develop/regauth/oui/oui.txt"

    test -z "${1}" && {
	error "arg0 must be a MAC address (i.e.: 00:11:22:33:44:55)"
	exit 2
    }

    if [[ ! -f "${tmpoui}" ]]; then
	/sbin/curl -kL -s -o "${tmpoui}" "${urloui}"
    fi && success "${_}"

    /sbin/grep -i "${mac2}" "${urloui}" && success "${mac2} ${_}"
}


extract_url(){
    local f="$1"
    [[ -f "$f" ]] && \
	cat "$f" | perl -wnl -e '/(http:\/\/\S+)/ and print $1' \
	|| error "$f"
}

### Derefence a shell variable
# ~ $ deref teag
# value of [teag] is: []
# ~ $ deref HOME
# value of [HOME] is: [/home/libcrack]
###

deref(){
    if [ -n "$1" ]; then
        localvar=$(eval echo \$$1)
        echo "value of [${1}] is: [${localvar}]"
    else
        echo "Null parameter passed to this function"
    fi
}


# vim: set noet ts=8 sw=4 sts=4 ft=sh:
