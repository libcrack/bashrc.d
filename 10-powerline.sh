### Powerline {{{

#powerline-daemon -q
#export TERM="xterm-256color"
#export POWERLINE_BASH_CONTINUATION=1
#export POWERLINE_BASH_SELECT=1
#pl="/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh"
#[[ -f "$pl" ]] && . "$pl"

#_update_ps1(){
#    local pl="/usr/lib/python2.7/site-packages/powerline/shell.py"
#    export PS1="$(python2 $pl $? 2> /dev/null)"
#}
#export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#}}}
