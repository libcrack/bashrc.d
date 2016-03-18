# libcrack@libcrack.so
# sab nov 29 15:10:27 CET 2014

# Coloured I/O procedures {{{
bold(){ echo -e "${BOLD}${*}${RESET}"; }
msg(){ echo -e "${BOLD}[*]${RESET} ${*}"; }
msgline(){ echo -e "${BOLD}[*] `perl -e 'print "-"x50'`${RESET}"; }
msgbox(){ msgline; echo -e "${BOLD}[*]${RESET} ${*}"; msgline; }

black()  { echo "$(tput setaf 0)${*}$(tput setaf 9)"; }
red()    { echo "$(tput setaf 1)${*}$(tput setaf 9)"; }
green()  { echo "$(tput setaf 2)${*}$(tput setaf 9)"; }
yellow() { echo "$(tput setaf 3)${*}$(tput setaf 9)"; }
blue()   { echo "$(tput setaf 4)${*}$(tput setaf 9)"; }
magenta(){ echo "$(tput setaf 5)${*}$(tput setaf 9)"; }
cyan()   { echo "$(tput setaf 6)${*}$(tput setaf 9)"; }
white()  { echo "$(tput setaf 7)${*}$(tput setaf 9)"; }
# }}}

# Error handling {{{
usage(){ echo -e "${BOLD}\n\t[*] ${*}${RESET}\n"; }
success(){ echo -e "${BOLD}${BGREEN}[✔]${RESET} ${*}"; }
error(){ echo -e "${BOLD}${IRED}[✘]${RESET} ${*}"; }
die(){ error "${*}"; return 1; }
die(){
    local myself="$(readlink -m ${0#-*})"
    local msg="${1}"
    [[ -n ${1} ]] || { echo "Usage: ${FUNCNAME} <msg>"; return 1; }
    error "${*}";
    [[ "$BASHPID" == "$$" ]] && return 1 || exit 1
if [[ "$BASH_SOURCE" == "$0" ]]; then
    echo "Usage: $0 <param1>" > /dev/stderr
    msg "Executed $0"
    return true
else
    msg "${FUNCNAME} sourced from $myself"
    return false
fi
}
# }}}

# Syslog {{{
toLogger(){
    daemon="${1}"
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
# }}}

# GDB backtrace {{{
gdb_get_backtrace() {
    [[ ${#} == 2 && -f "${1}" && -f "$2" ]] || {
        error "Usage: ${FUNCNAME} <exe> <core>"
        return
    }
    local exe=${1}
    local core=$2
    gdb -q ${exe} --core ${core} --batch
        -ex "thread apply all bt full"
        -ex "quit"
}
# }}}

# RPATH check {{{
rpath_check() {
    [[ "${#}" == 1 ]] || {
        error "Usage: ${FUNCNAME} <binary|directory>"
        return
    }
    [[ -f "${1}" ]] && readelf -d "${1}" | /bin/grep PATH
    [[ -d "${1}" ]] && for i in "${1}"; do readelf -d "$i" | /bin/grep PATH; done
}
#}}}

# gedit & sublime text {{{
gedit(){
    /usr/bin/gedit ${@} 2>/dev/null &
}

subl(){
    /usr/bin/subl ${@} 2>/dev/null &
}

subl3(){
    /usr/bin/subl3 ${@} 2>/dev/null &
}
# }}}

# Random MACs {{{
random-mac-qemu(){
    local RND="$(dd if=/dev/urandom bs=512 count=1 2>/dev/null \
        | md5sum \
        | sed 's/^\(..\)\(..\)\(..\).*$/\1:\2:\3/')"
    echo "52:54:00:$RND"
}

random-mac-deadbeef(){
    printf 'DE:AD:BE:EF:%02X:%02X\n' $((RANDOM%256)) $((RANDOM%256))
}

# https://pthree.org/2014/09/25/cryptographically-secure-pseudorandom-locally-administered-unicast-mac-addresses/
random-mac(){
    local rndmac="$((0x$(od /dev/urandom -N1 -t x1 -An | cut -c 2-) & 0xFE | 0x02))"
    printf '%02x' "${rndmac}"
    od /dev/urandom -N5 -t x1 -An | sed 's/ /:/g'
    # ip link set address $rndmac wlan0
}

# MAC addresses OUI look-up {{{
mac-lookup-oui(){

    if [ -z "${1}" ]; then
        error "Usage: ${FUNCNAME} <MAC addr>"
        return 2
    fi

    local mac="${1}"
    local mac1="${mac//:}"
    local mac_h="${mac1:0:6}"
    local mac_l="${mac1:6:12}"
    local ouidb="/usr/share/maclookup/oui.txt"
    local urloui="http://standards-oui.ieee.org/oui/oui.txt"

    if [[ ! -f "${ouidb}" ]]; then
	/sbin/curl -k -L -s -o "${ouidb}" "${urloui}"
    fi

    /bin/grep -i "${mac_h}" "${ouidb}"
    return $?
}
# }}}


# HTTP (dump vars, cookies, etc) {{{
http_params(){
    [[ -n ${1} ]] || die "${FUNCNAME} <uri>"
    python2 -c \
        "for i in '${1}'.split('&'): print i.split('=')[0]," \
        | tr ' ' ','
}
# }}}

whatismyip(){
    dig +short myip.opendns.com @resolver1.opendns.com
}

pastebin(){
    curl -F 'sprunge=<-' http://sprunge.us
}

transfer(){
    [[ $# -eq 0 ]] && \
	die "Usage: ${FUNCNAME} <local file> <remote file>"

    tty -s && {
        [[ -f "${1}" ]] || { error "File \"${1}\" does not exists"; return 1; }
        local basefile="$(basename "${1}" | sed -e 's/[^a-zA-Z0-9._-]/-/g')"
        curl --progress-bar --upload-file "${1}" "https://transfer.sh/${basefile}"
    } || curl --progress-bar --upload-file "-" "https://transfer.sh/${1}"
}

pdf-crypt(){
    [[ ${#} == 1 && -f "${1}" ]] \
	|| die "Usage: ${FUNCNAME} <pdf> [password]"

    local in="${1}"
    local passwd="$2"
    local out="${in//.pdf}-enc.pdf"

    [[ -z "$2" ]] && passwd="afd022d8f62222ebb12"

    msg "Encrypting ${out} using password ${passwd}"
    qpdf --password="" --decrypt "${in}" "${in}.$$"
    pdftk "${in}.$$" output "${out}" user_pw "${passwd}" allow AllFeatures
    rm "${in}.$$"
}
#}}}

# Tmux & screen TTY {{{
screen-ttyUSB(){
    /sbin/screen -t 'ttyUSB0 115200 8n1' /dev/ttyUSB0 "115200,-ixoff,-ixon"
}

tmux-ttyUSB(){
    /sbin/tmux -2 new-window $(which miniterm2.py) /dev/ttyUSB0 115200 \; attach;
}
#}}}

# Pacman maintenance {{{
pacman_outdated(){
    for pkg in $(pacman -Qqu); do
        # echo "$(pacman -Si "$pkg" | grep '^Versi' | sed 's/^Versi.n\s*:\s//')"
        echo "$pkg: $(pacman -Qi "$pkg" | grep '^Versi' | sed 's/^Versi.n\s*:\s//')"
    done
}
#}}}

# TED talk downloader {{{
tedtalk()
{
    [[ -z "${1}" ]]  && {
        echo -e "Usage: ${FUNCNAME} http://www.ted.com/talks/<talk_name>"
        return 1
    }

    local lang=
    local languages="es en"
    export TEDTALKS_CACHE="${XDG_CONFIG_HOME}/.tedtalks"

    for lang in ${languages}; do
        local video_url=$(curl -s "${1}" | perl -wnl -e \
            '/"'${lang}'":\{.+(http:.*'${lang}'.mp4).+\}/ and print ${1}')
        [[ ! -z "${video_url}" ]] && {
            msg "Opening ${BGREEN}${video_url}${RESET}"
            "$(which vlc)" "${video_url}" > /dev/null 2>&1 &
	    if [[ $! == 0 ]]; then
		echo "${video_url}" >> ${TEDTALKS_CACHE}
		return true
	    fi
        }
    done

    die "No spanish nor english subtitled video found"
    return false
}
# }}}

kill-gnome(){
    ps aux | egrep 'gnome-keyring-daemon|gvfs|gpg-agent|dirmgr' \
    | grep -v grep | awk '{print $2}' | xargs kill -9
}

# Gravatar downloader }}}
gravatar(){
    [[ -z "${1}" ]] && {
	error "Usage: ${FUNCNAME} user@host - grabs user@host's gravatar"
	return 88
    }

    local email="${1}"
    local email_img="${email}-gravatar.png"
    local email_md5="$(echo -n "${email}" | md5sum - | awk '{print ${1}}')"
    local gravatar_url="https://www.gravatar.com/avatar/${email_md5}"
    curl -s -k -L -o "${email_img}" "${gravatar_url}" \
      && success "${email_img}" \
	  || error "Error downloading \"${email_img}\""

    return $?
}
# }}}

valid-ip(){
    local ip="${1}"
    local stat=1

    if [[ "$#" == 1 ]]; then
	error "Usage: ${FUNCNAME} user@host - grabs user@host's gravatar"
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


extract_url(){
    local f="${1}"
    [[ -f "${f}" ]] && \
	cat "${f}" | perl -wnl -e '/(http:\/\/\S+)/ and print ${1}' \
	|| error "Usage: ${FUNCNAME} <file>"
}

# Derefence a shell variable
# ~ $ deref teag
# value of [teag] is: []
# ~ $ deref HOME
# value of [HOME] is: [/home/libcrack]

deref(){
    if [[ -n "${1}" ]]; then
        local localvar=$(eval echo \$${1})
        success "value of [${1}] is: [${localvar}]"
    else
        error "Null parameter passed to this function"
    fi
}

# vim: set noet ts=8 sw=4 sts=4 ft=sh:
