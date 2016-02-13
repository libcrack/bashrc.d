# Gnome-keyring-daemon conflicts with gpg-agent & ssh-agent
# Note that Gnome Keyring Daemon no longer exposes GNOME_KEYRING_PID:
#   :~ $ gnome-keyring-daemon --start
#   SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
#   GPG_AGENT_INFO=/run/user/1000/keyring/gpg:0:1
#
# More info: https://mail.gnome.org/archives/commits-list/2014-March/msg03864.html

GNOME_KEYRING_C="pkcs11,secrets,ssh,gpg"

## GPG2 Agent
# export GPG_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent"
# export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"

## SSH Agent
# export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"

### Gnome Keyring
#if [ -n "$DESKTOP_SESSION" ];then
#    eval $(gnome-keyring-daemon --start); export SSH_AUTH_SOCK
#    eval $(gnome-keyring-daemon --start); export SSH_AUTH_SOCK
#    eval $(gnome-keyring-daemon --start --components="${GNOME_KEYRING_C}"); export SSH_AUTH_SOCK
#    export GNOME_KEYRING_PID="$(ps aux | grep gnome-keyring-daemon | grep -v grep | awk '{print $2}')"
#fi
