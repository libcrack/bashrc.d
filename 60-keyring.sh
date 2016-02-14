# Gnome-keyring-daemon conflicts with gpg-agent & ssh-agent
# Note that Gnome Keyring Daemon no longer exposes GNOME_KEYRING_PID:
#   :~ $ gnome-keyring-daemon --start
#   SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
#   GPG_AGENT_INFO=/run/user/1000/keyring/gpg:0:1
#
# More info: https://mail.gnome.org/archives/commits-list/2014-March/msg03864.html

## GPG2 Agent
# export GPG_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent"
# export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"

## SSH Agent
# export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"

# Gnome Keyring
GNOME_KEYRING_C="pkcs11,secrets,ssh,gpg"
if [ -n "$DESKTOP_SESSION" ];then
    pgrep -f "gnome-keyring-daemon" > /dev/null && {
        logger -t "$LOGGERNAME" "Found running gnome-keyring-daemon"
    } || {
        logger -t "$LOGGERNAME" "Starting gnome-keyring-daemon"
        eval $(gnome-keyring-daemon --start --components="${GNOME_KEYRING_C}")
        export GNOME_KEYRING_PID="$(pgrep -f gnome-keyring-daemon)"
        export SSH_AUTH_SOCK
        export GPG_AUTH_SOCK
    }
fi
