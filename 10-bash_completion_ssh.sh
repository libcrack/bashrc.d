# START ssh completion

_compssh () {
  if [ -f "${HOME}/.ssh/config" ]; then
    cur=${COMP_WORDS[COMP_CWORD]};
    COMPREPLY=($(compgen -W '$(grep "^Host\b" ${HOME}/.ssh/config | sed -e "s/Host //")' -- $cur))
  fi
}
complete -F _compssh ssh

# END tmux completion
