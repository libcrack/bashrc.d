# test -f functions.sh && . functions.sh
# [[ -f ~/.bash_functions ]] && . ~/.bash_functions

# download full html page
alias wgetdownload='wget -np -nd -E -k -r -l 1 -e robots=off "$1"'

# download mp3 from youtube
youtubedownload(){
    [[ -e "$1" ]] || {
        youtube-dl "$1" \
            --extract-audio \
            -f best \
            --audio-quality 0 \
            --audio-format mp3
        return $?
    }
    return 1
}

wget-site-grabber(){
    [[ -z "$1" ]] \
        && error "$FUNCNAME <URL>" \
        && return
    wget \
        --recursive \
        --no-clobber \
        --page-requisites \
        --html-extension \
        --convert-links \
        --restrict-file-names=windows \
        --domains "${1%%/*}" \
        --no-parent \
        "$1"
}
