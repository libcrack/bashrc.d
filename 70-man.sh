# devnull@watergate.mad.libcrack.so
# 07/02/2016 08:09:07

mancolor() {
    env \
    LESS_TERMCAP_mb=$'\E[01;31m'      \
    LESS_TERMCAP_md=$'\E[01;38;5;75m' \
    LESS_TERMCAP_me=$'\E[0m'          \
    LESS_TERMCAP_se=$'\E[0m'          \
    LESS_TERMCAP_so=$'\E[38;5;11m'    \
    LESS_TERMCAP_ue=$'\E[0m'          \
    LESS_TERMCAP_us=$'\E[04;38;5;45m' \
    man "$@"
}

mancolor2() {
  env \
  LESS_TERMCAP_mb=$'\E[01;31m'       \
  LESS_TERMCAP_md=$'\E[01;38;5;74m'  \
  LESS_TERMCAP_me=$'\E[0m'           \
  LESS_TERMCAP_se=$'\E[0m'           \
  LESS_TERMCAP_so=$'\E[38;5;246m'    \
  LESS_TERMCAP_ue=$'\E[0m'           \
  LESS_TERMCAP_us=$'\E[04;38;5;146m' \
  man "$@"
}

