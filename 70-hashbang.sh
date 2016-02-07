hashbang-create-user()
{
    local user=$USER
    local server='hashbang.sh'
    local key="$(openssl rand 12 -hex)"
    local user="$(openssl rand 12 -hex)"
    local URL="https://hashbang.sh/user/create"

    curl -kL \
        -d '{"'"$user"'":"'"$user"'","'"$key"'":"'"$(cat ~/.ssh/id_rsa.pub)"'","host":"'"$server"'}' \
        -H 'Content-Type: application/json' \
        "$URL"
}
