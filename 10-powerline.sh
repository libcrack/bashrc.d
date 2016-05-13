# Powerline {{{
POWERLINE_ENABLE=false

if [ "${POWERLINE_ENABLE}" == "yes" ] \
  || [ "${POWERLINE_ENABLE}" == "true" ]; then
      $(which powerline-daemon) > /dev/null 2>&1
        if [ $? -eq 0 ]; then
           pgrep -f "powerline-daemon" > /dev/null 2>&1 \
               || powerline-daemon -q

           export TERM="xterm-256color"
           export POWERLINE_BASH_CONTINUATION=1
           export POWERLINE_BASH_SELECT=1
           export POWERLINE_BASH_BINDINGS="/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh"
           [[ -f "${POWERLINE_BASH_BINDINGS}" ]] && . "${POWERLINE_BASH_BINDINGS}"
           _update_ps1(){
               local pl="/usr/lib/python2.7/site-packages/powerline/shell.py"
               export PS1="$(python2 "$pl" "$?" 2> /dev/null)"
           }
           export PROMPT_COMMAND="_update_ps1; ${PROMPT_COMMAND}"
        fi
fi

# }}}
