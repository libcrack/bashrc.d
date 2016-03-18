
[[ -f ~/.bash_functions ]] && . ~/.bash_functions

# My HOME {{{
export BASHRC_HOME="${HOME}/.bashrc.d"
# }}}

export DESKTOP_SESSION=LXDE
export EDITOR=vim
export PAGER=most

## Powerline prompt {{{
export POWERLINE_ENABLE="yes"
export POWERLINE_BASH_SELECT=1
export POWERLINE_BASH_CONTINUATION=1
# }}}

## Git prompt
# export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"

# PATH {{{
export PATH="${HOME}/bin:${PATH}"
export PATH="${HOME}/scripts:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"
# }}}

# Perl {{{
export PATH="/usr/bin/core_perl:${PATH}"
# }}}

# Libvirtd {{{
export LIBVIRT_DEFAULT_URI="qemu:///system"
# }}}

# Web2py {{{
export WEB2PY_HOME="${HOME}/web2py"
# }}}

# Logging {{{
export LOGGERNAME="bashrc.d"
# }}}

# Skype hotfix {{{
# export PULSE_LATENCY_MSEC=60
# export PULSE_LATENCY_MSEC=30
# }}}

# XDG Base Directory Specification {{{
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share:/usr/share}"
# }}}
