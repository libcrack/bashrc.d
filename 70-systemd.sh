#no shebang here Lennart biatch
###############################
# vie feb 13 22:13:48 CET 2015
# devnull@libcrack.so
###############################
# FUCK SYSTEMD!!!!
# FUCK LENNART POETTERING!!!!
###############################

fuck_systemd(){
    RAND_MAX=32767
    [[ $RANDOM > $(($RAND_MAX/2)) ]] && {
        red "FUCK SYSTEMD"
    } || {
        yellow "FUCK LENNART POETTERING"
    }
}
