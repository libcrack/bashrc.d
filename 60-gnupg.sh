# GPG2 Agent environment
export GNUPGHOME="${HOME}/.gnupg"
export GPG_TTY="$(tty)"

export GPG_KEYSERVER_MIT="hkp://pgp.mit.edu:11371"
export GPG_KEYSERVER_GPG="hkp://keys.gnupg.net:11371"
export GPG_KEYSERVER="${GPG_KEYSERVER_GPG}"

# [[ -f "${GNUPGHOME}"/gpg-agent-wrapper ]] \
#     && . "${GNUPGHOME}"/gpg-agent-wrapper
#
# # Replace ssh-agent
# export GPG_AUTH_SOCK="${GNUPGHOME}/S.gpg-agent"
# export SSH_AUTH_SOCK="${GNUPGHOME}/S.gpg-agent.ssh"

gpg-key-search(){
    gpg --keyserver "${GPG_KEYSERVER}" --search "$@"
}

