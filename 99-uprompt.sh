#unicode_prompt () {
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
#PROMPT_COMMAND='unicode_prompt'
