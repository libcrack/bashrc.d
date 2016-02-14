#!/usr/bin/env bash
# devnull@watergate.mad.libcrack.so
# 07/02/2016 05:25:14
#
# zenity --info      --title="Info"  --text="Hello World"
# zenity --error     --title="Error" --text="An Error Occurred"
# zenity --entry     --title="Query" --text="Please enter Full path"
# zenity --question  --title="Quest" --text="Do you really want to drink?"
# zenity --error --title="An Error Occurred" --text="asd" > /dev/null 2>&1
#
# ZENITY_T=(color-selection file-selection forms list notification
# password progress scale entry text-info error warning question info)
# for t in ${ZENITY_T[@]}; do
#     zenity "--${t}" --title "${t}" --text "Trying ${t}"
#     read -p "(next)>"
# done
#
# ico=~/Imagenes/iconos/pentest.ico
# zenity  --notification --window-icon="$ico"  --text "Version updated"
# find "$HOME" -name "*.mp3" | zenity --progress --pulsate
# find . -name "*.py" | zenity  --title  "Search  Results" --list --text "Python files" --column "Files"
#

errorz(){
    zenity --error --title="An Error Occurred" --text="${@}" \
        > /dev/null 2>&1 &
}

msgz(){
    zenity --info --title="Info" --text="${@}" \
        > /dev/null 2>&1 &
}
