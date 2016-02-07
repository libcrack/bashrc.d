randompass(){
    local len="8"
    test -z "$1" || len="$1"
    openssl rand -hex "$len"
}
