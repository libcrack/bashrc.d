##
## http://misc.flogisoft.com/bash/tip_colors_and_formatting
##

# Escape characters
# \040 => terminador de prompt para no-wrap newline ???
# \070 => terminador de prompt para no-wrap newline ???
# \[\007\] => last escape ???

# Line wrap + lxterm hack
shopt -s checkwinsize

[[ -f ~/.git-prompt.sh ]] && . ~/.git-prompt.sh
[[ -f ~/.bash_functions.sh ]] && . ~/.bash_functions.sh
[[ -f ~/.bashrc.d/git-prompt.sh ]] && . ~/.bashrc.d/git-prompt.sh
[[ -f /usr/share/git/git-prompt.s ]] && . ~/.bashrc.d/git-prompt.sh

__pentest_ps1(){
    local pwd="$(realpath $PWD)"
    local cur="$(realpath $PENTEST_TASK_CURRENT)"
    ### ALSO VALID
    #[[ "${pwd:0:${#cur}}" == $cur ]] \
    #     && echo -e "${IYELLOW}($(basename ${cur%%-*}))${RESET}"
    [[ "${pwd##$cur}" != "$pwd" ]] \
        && echo -e "${IYELLOW}($(basename ${cur%%-*}))${RESET}"
}

##
## GIT NO COLOR
##
# export PS1='[\u@\h \W$(__git_ps1 "(%s)")]\$ '

##
## GIT COLOR
##
# export PS1='\h \w $(__git_ps1 "(%s)") \$ '
# export PS1='\[\e[33m\]\h\[\e[0m\]:\W\[\e[33m\]$(__git_ps1 "(%s)") \[\e[0m\] \u\$ '
# export PS1="\n\e[1;30m[\e[0;22m\T\e[1;30m][\e[1;32m\u@\H\e[1;30m]\e[1;37m[\w]\n \$(__git_ps1 "(%s)") >>> "
# export PS1='\n\e[1;30m[\e[0;22m\T\e[1;30m][\e[1;32m\u@\H\e[1;30m:\e[1;37m[\w]\n $(__git_ps1 "(%s)") \[\007\] >>> '
# export PS1='\[\033[01;37m\]\u\[\033[01;34m\]@\[\033[01;37m\]\h\[\033[01;34m\]:\[\033[01;32m\]\w\[\033[0;31m\] $(__git_ps1 "(%s)") \[\033[00m\] \$ '

##
## PENTEST TASK prompt if $PWD == $PENTEST_TASK_CURRENT
## if true, \w aka "working dir" is not included
##

# SAME OLD
# export PS1="\[\033[01;37m\]\u\[\033[01;34m\]@\[\033[01;37m\]\h\[\033[01;34m\]:\[\033[01;32m\]\w\[\033[0;31m\]\$(__git_ps1)\[\033[00m\] \$\007 "
# export PS1="\[\033[01;37m\]\u\[\033[01;34m\]@\[\033[01;37m\]\h\[\033[01;34m\]:\[\033[01;32m\]\w\[\033[0;31m\]\$(__git_ps1)\[\033[00m\] \$\007"

#
# export PS1="\[\033[01;37m\]\u\[\033[01;34m\]@\[\033[01;37m\]\h
# export PS1="\[\033[01;34m\]:\[\033[01;32m\]\w\[\033[0;31m\]\$(__git_ps1)\[\033[00m\] \$ "

# GREEN + YELLOW + \w
#export PS1='\[\033[1;30m\][\[\033[1;32m\]\w\[\033[0;31m\] $(__git_ps1 "(%s)")$(__pentest_ps1)\[\033[1;30m\]]\[\033[0m\]\$ \[\007\]'

# GREEN + YELLOW + \u@\h:\W
# export PS1='[\[\033[01;37m\]\u\[\033[01;34m\]@\[\033[01;37m\]\h\[\033[01;34m\]:\[\033[01;32m\]\W\[\033[0;31m\] $(__git_ps1 "(%s)")$(__pentest_ps1)\[\033[00m\]]\$\[\007\] '

# GREEN + YELLOW + \u@\h:\w
#export PS1="[\[\033[01;37m\]\u\[\033[01;34m\]@\[\033[01;37m\]\h\[\033[01;34m\]:\[\033[01;32m\]\w\[\033[0;31m\] \$(__git_ps1 "(%s)")\$(__pentest_ps1)\[\033[00m\]]\$\[\007\] "

##
## SIMPLE NO GIT
##

# export PS1="[\w]$ "
# export PS1="(\w)> "
# export PS1='\u@\h \w \$ '
# export PS1='[\u@\h \W]\$ '
# export PS1="\e[1m(\w)>\e[0m "
# export PS1="\e[1;34m(\w)>\e[0m "
# export PS1="\[\033[01;1m\](\w)>\[\033[0m\] "
# export PS1="\[\033[1m\](\w)>\[\033[0m\] "
# export PS1="\[\033[1;31m\](\w)> \[\033[0m\]"
# export PS1="\[\033[1;32m\](\w)> \[\033[0m\]"
# export PS1='[\[\e[0;33m\]\h\[\e[0m\]:\[\e[0;33m\]\W\[\e[0m\]]\$ '
# export PS1='\[\033[01;31m\]\h\[\033[01;32m\] \w \[\033[01;34m\]\$\[\033[00m\] '
# export PS1="\e[0;30m\u\e[1;34m@\e[0;30m\h\e[1;34m:\e[0;30m\w\e[1;34m:\e[1;34m \$\e[0;30m "

##
## NEAT
##
# export PS1="\[$(tput setaf 1)\]┌─╼ \[$(tput setaf 7)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────╼ \[$(tput setaf 7)\][\H:\W]\"; else echo \"\[$(tput setaf 1)\]└╼ \[$(tput setaf 7)\][\u]\"; fi) \[$(tput setaf 7)\]"
# export PS1="\[$(tput setaf 1)\]┌─╼ \[$(tput setaf 7)\][\w]\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────╼\"; else echo \"\[$(tput setaf 1)\]└╼\"; fi) \[$(tput setaf 7)\]"

##
## MADNESS
##

# export PS1='\e[1;38;5;56;48;5;234m\u \e[38;5;240mon \e[1;38;5;28;48;5;234m\h \e[38;5;54m\d \@\e[0m\n\e[0;38;5;56;48;5;234m[\w] \e[1m\$\e[0m '

# declare -x PS1="\\[\\e[m\\n\\e[1;30m\\][\$\$:\$PPID \\j:\\!\\[\\e[1;30m\\]]\\[\\e[0;36m\\] \\T \\d \\[\\e[1;30m\\][\\[\\e[1;34m\\]\\u@\\H\\[\\e[1;30m\\]:\\[\\e[0;37m\\]\${SSH_TTY} \\[\\e[0;32m\\]+\${SHLVL}\\[\\e[1;30m\\]] \\[\\e[1;37m\\]\\w\\[\\e[0;37m\\] \\n(\$SHLVL:\\!)\\\$ "

# export PROMPT_COMMAND='echo -en "\033[m\033[38;5;2m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"'     export PS1='\[\e[m\n\e[1;30m\][$$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n($SHLVL:\!)\$ '

# export PS1='\n\e[1;30m[\j:\!\e[1;30m]\e[0;36m \T \d \e[1;30m[\e[1;34m\u@\H\e[1;30m:\e[0;37m`tty 2>/dev/null` \e[0;32m+${SHLVL}\e[1;30m] \e[1;37m\w\e[0;37m\[\033]0;[ ${H1}... ] \w - \u@\H +$SHLVL @`tty 2>/dev/null` - [ `uptime` ]\007\]\n\[\]\$ '

# PROMPT_COMMAND='echo -en "\033[m\033[38;5;2m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"'     export PS1='\[\e[m\n\e[1;30m\][$$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n($SHLVL:\!)\$ ' ; echo -e $PROMPT_COMMAND

# declare -x PS1="\\[\\e[m\\n\\e[1;30m\\][\$\$:\$PPID \\j:\\!\\[\\e[1;30m\\]]\\[\\e[0;36m\\] \\T \\d \\[\\e[1;30m\\][\\[\\e[1;34m\\]\\u@\\H\\[\\e[1;30m\\]:\\[\\e[0;37m\\]\${SSH_TTY} \\[\\e[0;32m\\]+\${SHLVL}\\[\\e[1;30m\\]] \\[\\e[1;37m\\]\\w\\[\\e[0;37m\\] \\n(\$SHLVL:\\!)\\\$ "

# export PROMPT_COMMAND='echo -en "\033[m\033[38;5;2m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"'     export PS1='\[\e[m\n\e[1;30m\][$$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n($SHLVL:\!)\$ '

# export PS1='\n\e[1;30m[\j:\!\e[1;30m]\e[0;36m \T \d \e[1;30m[\e[1;34m\u@\H\e[1;30m:\e[0;37m`tty 2>/dev/null` \e[0;32m+${SHLVL}\e[1;30m] \e[1;37m\w\e[0;37m\[\033]0;[ ${H1}... ] \w - \u@\H +$SHLVL @`tty 2>/dev/null` - [ `uptime` ]\007\]\n\[\]\$ '

# export PS1='\n\e[1;30m[\j:\!\e[1;30m]\e[0;36m \T \d \e[1;30m[\e[1;34m\u@\H\e[1;30m:\e[0;37m`tty 2>/dev/null` \e[0;32m+${SHLVL}\e[1;30m] \e[1;37m\w\e[0;37m\[\033]0;[ ${H1}... ] \w - \u@\H +$SHLVL @`tty 2>/dev/null` - [ `uptime` ]\007\]\n\[\]\$ '

#     echo -n "KingBash> $READLINE_LINE" #Where "KingBash> " looks best if it resembles your PS1, at least in length.

##
## UTF-8 COMMAND PROMPT
##

#export PS1='`if [ $? = 0 ]; then echo "\[\033[01;32m\]✔"; else echo "\[\033[01;31m\]✘"; fi` \[\033[01;30m\]\h\[\033[01;34m\] \w\[\033[35m\]$(__git_ps1 " %s") \[\033[01;30m\]>\[\033[00m\] '

#export PS1='\[\e[01;30m\]\t \[\e[31m\]\u\[\e[37m\]:\[\e[33m\]\w\[\e[31m\]\$\[\033[00m\] '

#export PS1='\[\e[01;30m\]\t`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\e[00;37m\]\u\[\e[01;37m\]:`[[ $(git status 2> /dev/null | head -n2 | tail -n1) != "# Changes to be committed:" ]] && echo "\[\e[31m\]" || echo "\[\e[33m\]"``[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\]\w\[\e[00m\]\$ '

#export PS1='\[\033[01;30m\]\t `if [ $? = 0 ]; then echo "\[\033[01;32m\]ツ"; else echo "\[\033[01;31m\]✗"; fi` \[\033[00;32m\]\h\[\033[00;37m\]:\[\033[31m\]$(__git_ps1 "(%s)\[\033[01m\]")\[\033[00;34m\]\w\[\033[00m\] > '

#export PS1='\[\033[01;30m\]\t `if [ $? = 0 ]; then echo "\[\033[01;32m\]ツ"; else echo "\[\033[01;31m\]✗"; fi` \[\033[00;31m\]\h\[\033[00;37m\]:\[\033[00;34m\]\w\[\033[00m\] > '

#export PS1='`if [ $? = 0 ]; then echo "\[\033[01;32m\]✔"; else echo "\[\033[01;31m\]✘"; fi` \[\033[01;30m\]\h\[\033[01;34m\] \w\[\033[35m\]$(__git_ps1 " %s") \[\033[01;31m\]\n>\[\033[00m\] '

#PS1='`if [ $? = 0 ];then echo "\[\033[01;32m\][✔]";else echo "\[\033[01;31m\][✘]";fi `\u@\[\033[01;30m\]\h:\[\033[01;34m\]\w\[\033[35m\] ($(__git_ps1 "%s"))\[\033[01;31m\] \$\[\033[00m\] '

#set_prompt () {
#    Last_Command=$? # Must come first!
#    Blue='\[\e[01;34m\]'
#    White='\[\e[01;37m\]'
#    Red='\[\e[01;31m\]'
#    Green='\[\e[01;32m\]'
#    Reset='\[\e[00m\]'
#    FancyX='\342\234\227'
#    Checkmark='\342\234\223'
#
#    # Add a bright white exit status for the last command
#    PS1="$White\$? "
#    # If it was successful, print a green check mark. Otherwise, print
#    # a red X.
#    if [[ $Last_Command == 0 ]]; then
#        PS1+="$Green$Checkmark "
#    else
#        PS1+="$Red$FancyX "
#    fi
#    # If root, just print the host in red. Otherwise, print the current user
#    # and host in green.
#    if [[ $EUID == 0 ]]; then
#        PS1+="$Red\\h "
#    else
#        PS1+="$Green\\u@\\h "
#    fi
#    # Print the working directory and prompt marker in blue, and reset
#    # the text color to the default.
#    PS1+="$Blue\\w \\\$$Reset "
#}
#PROMPT_COMMAND='set_prompt'

# Alternative with only errors
# PROMPT_COMMAND='es=$?; [[ $es -eq 0 ]] && unset error || error=$(echo -e "\e[1;41m $es \e[40m")'
# PS1="${error} ${PS1}"

# PS1 GIT flavoured
# alias prompt="export PS1='[\u@\h \W]\$ '"

# Simple cool (ojo al \007 que evita el shell cmd  wrapping)
# export PS1="\[\e[36;1m\]\u@\H(\w) ->> \[\e[0m\]\007"

# Multi color prompt
# export PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'
# export PS1="\n╔═[\[\033[01;36m\]\A\[\033[01;00m\]]═[\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;31m\]\h\[\033[01;00m\]]\n\[\033[01;00m\]╚═══\[\033[00;32m\]=\[\033[00;33m\]=\[\033[00;31m\]=\[\033[01;00m\]═══[\[\033[01;36m\]\$CurDir\[\033[01;00m\]]\[\033[01;32m\]>>\[\033[00m\]\007"

# Custom I
# alias prompt="export PS1='[\u@\h:\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '"
# export PS1='\[\e[22;1m\]\u@\H(\w)\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
# export PS1="\[\e[22;1m\]\u@\H(\w)\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ "
# export PS1='[\u@\h:\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
# export PS1="\[\e[33;1m\]\u@\H(\w)>>\[\e[0m\]\007\$ "

# Custom II
# export PS1='\[\e[22;1m\]\u@\H(\w)\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
# export PS1="\[\e[22;1m\]\u@\H(\w)\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ "
# export PS1="\[\e[36;1m\]\u@\H(\w)->>\[\e[0m\]\007"
# export PS1="\[\e[36;1m\]\u@\H(\w)->>\[\e[0m\]\007"
# export PS1="\[\e[33;1m\]\u@\h(\w)->>\[\e[0m\]\007"
# export PS1="\[\e[33;1m\]\u@(\w)->>\[\e[0m\]\007"
# export PS1="\[\e[33;1m\]\u@\H->>\[\e[0m\]\007"

# Custom III
# alias setps1='export PS1="\[\e[33;1m\]\u@\H(\w)>>\[\e[0m\]\007\\$ "'
# export PS1='\[\e[33;1m\]\u@\H(\w)->>\[\e[0m\]\007'
# export PS1="\[\e[36;1m\]\u@\H(\w)->>\[\e[0m\]\007"

# export PS1="\[$(tput setaf 1)\]┌─╼\[$(tput setaf 7)\](\w)\n\[$(tput setaf 1)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 1)\]└────────────>>\"; else echo \"\[$(tput setaf 1)\]└────────────>>\"; fi) \[$(tput setaf 7)\]"

# export PS1="\[$(tput setaf 2)\]┌─╼\[$(tput setaf 7)\](\w)\n\[$(tput setaf 7)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 7)\]└────────────>>\"; else echo \"\[$(tput setaf 2)\]└────────────>>\"; fi) \[$(tput setaf 7)\]"

# export PS1="\[$(tput setaf 3)\]┌─╼\[$(tput setaf 7)\](\w)\n\[$(tput setaf 3)\]\$(if [[ \$? == 0 ]]; then echo \"\[$(tput setaf 3)\]└────────────>>\"; else echo \"\[$(tput setaf 3)\]└────────────>>\"; fi) \[$(tput setaf 7)\]"

# Bash PS1
# export PS1="\[\e[36;1m\]\u@\H(\w) ->> \[\e[0m\]\007"

# Multicolor (escape char \007 stops line wrapping)
# export PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'
# export PS1="\n╔═[\[\033[01;36m\]\A\[\033[01;00m\]]═[\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;31m\]\h\[\033[01;00m\]]\n\[\033[01;00m\]╚═══\[\033[00;32m\]=\[\033[00;33m\]=\[\033[00;31m\]=\[\033[01;00m\]═════════[\[\033[01;36m\]\$CurDir\[\033[01;00m\]]\[\033[01;32m\]>>\[\033[00m\]\007\\$ "

# # Detect tilda #1
# pname="$(ps aux | grep "$PPID" | grep -v grep | awk '{print $11}')"
# alias prompt="export PS1='[\u@\h:\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '"
# [[ -z "$TERMINATOR_UUID" && -z "$TMUX" && "$pname" != "tilda" ]] && prompt

# # Detect tilda #2
# pname="$(/bin/ps --no-headers -u -p "$PPID" | awk '{print $11}')"
# [[ -z "$TERMINATOR_UUID" && -z "$TMUX" && "$pname" != "tilda" ]] \
#   && export PS1='[\u@\h:\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
#

# # Detect tilda #3
# pname="$(ps aux | grep "$PPID" | grep -v grep | awk '{print $11}')"
# [[ -z "$TERMINATOR_UUID" && -z "$TMUX" && "$pname" != "tilda" ]] \
#     && export PS1='[\u@\h:\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '

# Detect tilda #4
pname="$(ps $PPID | grep -v TTY | awk '{print $5}')"
if [[ ! -n "$TERMINATOR_UUID" ]] && [[ ! -n "$TMUX" ]]; then
    if [[ "$pname" =~ lxterminal ]]; then
        export PS1='[\u@\h:\W]\[\033[0;31m\]$(__git_ps1 "(%s)")\[\033[00m\]\$ '
    else
        export PS1='\[\e[1;33m\](\W\[\e[0m\]\[\e[0;31m\]$(__git_ps1 ":%s")\[\e[1;33m\])>>\[\e[0m\] '
    fi
fi

### XXX PUT HERE YOUR PS1
# export PS1='\[\e[1;33m\](\W\[\e[0m\]\[\e[0;31m\]$(__git_ps1 ":%s")\[\e[1;33m\])>>\[\e[0m\] '

# source ~/.bashrc.d/git-prompt.sh
# export PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'
# export PS1="\n╔═[\[\033[01;36m\]\A\[\033[01;00m\]]═[\[\033[01;32m\]\u\[\033[01;33m\]@\[\033[01;31m\]\h\[\033[01;00m\]]\n\[\033[01;00m\]╚═══\[\033[00;32m\]=\[\033[00;33m\]=\[\033[00;31m\]=\[\033[01;00m\]═════════[\[\033[01;36m\]\$CurDir\[\033[01;00m\]]\[\033[01;32m\]>>\[\033[00m\]\007\\$ "

# export PS1='\[\e[1;33m\](\W)\[\e[0m\]>>\[\e[0;31m\]$(__git_ps1 "(%s)")\[\e[0m\]\$ '
# export PS1='\[\e[33;1m\](\W)>>\[\e[0m\] '
# export PS1='\[\e[1;33m\](\W)\[\e[0m\]\[\e[0;31m\]$(__git_ps1 "{%s}")\[\e[0m\]>> '

# \[\e[0;31m\]   XXX \[\e[0m\]
# \[\033[0;31m\] XXX \[\033[0m\]


# }}}
