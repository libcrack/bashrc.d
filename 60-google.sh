google() {
    local google_url='https://www.google.de/search?tbs=li:1&q=';
    local q="$@";
    local agent="Mozilla/4.0"
    local stream="$(curl -A "$agent" -skLm 10 "${google_url}${q//\ /+}" \
        | grep -a -oP '\/url\?q=.+?&amp' \
        | sed 's|/url?q=||; s|&amp||')"
    printf "${stream//\%/\x}\n"
}

