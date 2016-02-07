export ASCIINEMA_HOME="${HOME}/asciicast"
export ASCIINEMA_AUTOUPLOAD="yes"

asciinema-rec()
{
    local title="untitled"
    [[ -z "$1" ]] || title="$1"
    local title="${title}-$(date "+%d%m%Y_%H%M%S")"
    local json="${ASCIINEMA_HOME}/${title}.json"

    asciinema rec \
        -t "$title" -w 1 -y \
        -c "/usr/bin/tmux -2 new-session -s $title" "$json" && {
            echo -e "\e[32m✔\e[0m Sesson saved: $json"
            [[ "$ASCIINEMA_AUTOUPLOAD" =~ (1|true|yes|YES|on) ]] &&
                msg "Auto uploading $json to asciinema ... "
                asciinema upload "$json" \
                    && echo -e "\e[32m✔\e[0m" "$_"  \
                    || echo -e "\e[12m✘\e[0m" "$_"
        } || {
           if [[ ! -f "$json" ]]; then
             echo -e "\e[31m✘\e[0m Failed to save \"$json\""
           fi
        }
}

asciinema-rec-bis(){
    asciinema rec -c "/usr/bin/tmux -2 new-session" \
        -t "$(date2)" -w 1 -y "$ASCIINEMA_HOME/$RANDOM.json" \
        && asciinema upload "$_"
}

