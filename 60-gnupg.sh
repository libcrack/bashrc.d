### GPG2 AGENT ENVIRONMENT
export GNUPGHOME="${HOME}/.gnupg"
export GPG_AUTH_SOCK="${GNUPGHOME}/S.gpg-agent"
export SSH_AUTH_SOCK="${GNUPGHOME}/S.gpg-agent.ssh"
export GPG_KEYSERVER="hkp://newheap.lab.pentest.co.uk:11371"
export GPG_KEYSERVER_MIT="hkp://pgp.mit.edu:11371"
export GPG_KEYSERVER_GPG="hkp://keys.gnupg.net:11371"
export GPG_TTY="$(tty)"

# source ${GNUPGHOME}/.gpg-agent-wrapper
source ${GNUPGHOME}/gpg-agent-wrapper

gpg-key-search(){
    gpg --keyserver "$GPG_KEYSERVER" --search "$@"
}

