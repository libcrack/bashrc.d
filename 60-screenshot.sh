export SCREENSHOT_HOME="${HOME}/Imagenes/screenshots"

screenshot-xclip(){
    [[ -d "${SCREENSHOT_HOME}" ]] || {
        error "$FUNCNAME: Cannot find screenshot dir \"${SCREENSHOT_HOME}\""
        return 1
    }
    which scrot > /dev/null 2>&1 || {
        error "$FUNCNAME: Cannot find scrot, please install it"
        return 1
    }
    name="${RANDOM}"
    [[ -z "$1" ]] || name="$1"
    date="$(date "+%d%m%Y_%H%M%S")"
    file="${SCREENSHOT_HOME}/${name}-${date}.png"
    scrot -b -s "$file" | xclip -in
}
