# devnull@libcrack.so
# Sab ene 10 16:53:26 CET 2015
#
# Python stuff


## Toogle between python versions
python-toggle(){
    test -z "$1" || v="$1"
    local bins=('python' 'python-config' 'pip')
    cd /usr/bin
    for bin in ${bins[@]}; do
        test -e $bin || {
            echo -e "${RED}ERROR:${RESET} cannot find $PWD/$bin"
            return 1
        }
    done
    echo -e ">> ${RED}Disabled $(python -V 2>&1)${RESET}\007"
    if [[ python -ef python3 || "python${v}" == "python3" ]]; then
        sudo rm python python-config pip
        sudo ln -s python2 python
        sudo ln -s python2-config python-config
        sudo ln -s pip2 pip
    elif [[ python -ef python2 || "python${v}" == "python2" ]]; then
        sudo rm python python-config pip
        sudo ln -s python3 python
        sudo ln -s python3-config python-config
        sudo ln -s pip3 pip
    else
        echo -e "${RED}ERROR:${RESET} cannot find link /usr/bin/$bin"
        cd - > /dev/null
        return 2
    fi
    echo -e ">> ${GREEN}Enabled $(python -V 2>&1)${RESET}\007"
    cd - > /dev/null
}
py2-enable(){ py-toggle 2; }
py3-enable(){ py-toggle 3; }
py-toggle(){ python-toggle ${@}; }
## Python virtual envs
# sudo pacman -S python2-virtualenv
# mkdir ~/.python
# cd ~/.python
# virtualenv2 27
# virtualenv3 33
python-venv(){
    local activate=~/.python/$1/bin/activate
    if [[ -e "$activate" ]]; then
        echo -ne "${GREEN}>>${RESET} "
        echo "Enabling python virtual env $activate"
        source "$activate"
    else
        echo -ne "${RED}ERROR:${RESET} "
        echo "Python virtual env not found: $activate"
    fi
}
py-venv27() { py-venv 27 ; }
py-venv33() { py-venv 33 ; }
py-venv(){ python-venv ${@}; }
## Assemble the command "archlinux-java"
archlinux-python(){ python-toggle; }
