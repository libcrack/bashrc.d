# =====[ Colors ]==================================================================

# Colors (all works)
# BOLD="\033[1m"
# RESET="\033[0m"
# BOLD="\033[01;37m"
# BOLD="\e[01;37m"
# RESET="\e[0;0m"
# \e[92m => igreen
# \e[0;92m => green

export RED="\e[0;31m"
export GREEN="\e[0;32m"
export YELLOW="\e[0;33m"
export BLUE="\e[0;34m"
export IRED="\e[0;31m"
export IGREEN="\e[0;32m"
export IYELLOW="\e[0;33m"
export IBLUE="\e[0;34m"
export BRED="\e[1;31m"
export BGREEN="\e[1;32m"
export BOLD="\e[1m"
export RESET="\e[0m"
#BOLD="\033[1m"
#RESET="\033[0m"

# print
bold()  { echo -e "${BOLD}${1}${RESET}";   }
red()   { echo -e "${RED}${1}${RESET}";    }
blue()  { echo -e "${BLUE}${1}${RESET}";   }
green() { echo -e "${GREEN}${1}${RESET}";  }
yellow(){ echo -e "${YELLOW}${1}${RESET}"; }
print() { echo -e "[${GREEN}$*${RESET}]";  }
export -f bold red blue green print

### Gentoo colors
# export LS_COLORS="st=38;5;202:di=38;5;28:*.h=38;5;81:*.rb=38;5;192:*.c=38;5;110:*.diff=42;38:*.yml=38;5;208:*.PL=38;5;178:*.csv=38;5;136:tw=38;5;003:*.chm=38;5;144:*.bin=38;5;249:*.sms=38;5;33:*.pdf=38;5;203:*.cbz=38;5;140:*.cbr=38;5;140:*.nes=38;5;160:*.mpg=38;5;38:*.ts=38;5;39:*.sfv=38;5;191:*.m3u=38;5;172:*.txt=38;5;192:*.log=38;5;190:*.bash=38;5;173:*.swp=38;5;238:*.swo=38;5;109:*.theme=38;5;109:*.zsh=38;5;173:*.nfo=38;5;113:mi=38;5;124::or=38;5;160:ex=38;5;197:ln=target:pi=38;5;126:ow=38;5;208:*.pm=38;5;197:*.pl=38;5;107:*.sh=38;5;245:*.patch=40;33:*.tar=38;5;118:*.tar.gz=38;5;118:*.zip=38;5;11::*.rar=38;5;11:*.tgz=38;5;11:*.7z=38;5;11:*.mp3=38;5;173:*.mp4=38;5;174:*.flac=38;5;166:*.mkv=38;5;115:*.avi=38;5;114:*.wmv=38;5;113:*.jpg=38;5;66:*.jpeg=38;5;66:*.png=38;5;68:*.pacnew=38;5;33:*.torrent=38;5;94:*.srt=38;5;242:*.sub=38;5;242:*.aria2=38;5;242"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export GREP_COLORS="38;5;230:sl=38;5;240:cs=38;5;100:mt=38;5;161:fn=38;5;197:ln=38;5;212:bn=38;5;44:se=38;5;166"
export LS_COLORS="${LS_COLORS}*.md=00;36"

# colored exec
color_exec(){
    echo -n "[*] "
    echo "$*" | ccze -A
    $*
}

color_cheatsheet_ansi() {
    for a in 0 1 4 5 7; do
        echo "a=$a "
        for (( f=0; f<=9; f++ )) ; do
            for (( b=0; b<=9; b++ )) ; do
                #echo -ne "f=$f b=$b"
                echo -ne "\\033[${a};3${f};4${b}m"
                echo -ne "\\\\\\\\033[${a};3${f};4${b}m"
                echo -ne "\\033[0m "
            done
        echo
        done
        echo
    done
    echo
}

color_cheatsheet_term(){
    echo
    local fgc bgc vals seq0
    printf "Color escapes are %s\n" '\e[${value};...;${value}m'
    printf "Values 30..37 are \e[33mforeground colors\e[m\n"
    printf "Values 40..47 are \e[43mbackground colors\e[m\n"
    printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"
    # foreground colors
    for fgc in {30..37}; do
        # background colors
        for bgc in {40..47}; do
            fgc=${fgc#37} # white
            bgc=${bgc#40} # black

            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}

            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
            done
            echo; echo
    done
}

# ANSI color scheme script by pfh
# Initializing mod by lolilolicon from Archlinux

colors_dna(){

    f=3 b=4
    for j in f b; do
      for i in {0..7}; do
        printf -v $j$i %b "\e[${!j}${i}m"
      done
    done
    bld=$'\e[1m'
    rst=$'\e[0m'
    inv=$'\e[7m'

    cat << EOF

 $f1█-----$bld█  $rst$f2█-----$bld█$rst  $f3█-----$bld█$rst  $f4█-----$bld█$rst  $f5█-----$bld█$rst  $f6█-----$bld█$rst
  $f1█---$bld█$rst    $f2█---$bld█$rst    $f3█---$bld█$rst    $f4█---$bld█$rst    $f5█---$bld█$rst    $f6█---$bld█$rst
  $f1--$rst█$rst     $f2 █-$bld█$rst     $f3 █-$bld█$rst     $f4 █-$bld█$rst     $f5 █-$bld█$rst     $f6 █-$bld█$rst
    $f1█$rst        $f2█$rst        $f3█$rst        $f4█$rst        $f5█$rst        $f6█$rst
   $f1$bld█-$rst$f1█$rst      $f2$bld█_$rst$f2█$rst      $f3$bld█-$rst$f3█$rst      $f4$bld█-$rst$f4█$rst      $f5$bld█-$rst$f5█$rst      $f6$bld█-$rst$f6█$rst
  $f1$bld█---$rst$f1█$rst    $f2$bld█---$rst$f2█$rst    $f3$bld█---$rst$f3█$rst    $f4$bld█---$rst$f4█$rst    $f5$bld█---$rst$f5█$rst    $f6$bld█---$rst$f6█$rst
 $f1$bld█-----$rst$f1█$rst  $f2$bld█-----$rst$f2█$rst  $f3$bld█-----$rst$f3█$rst  $f4$bld█-----$rst$f4█$rst  $f5$bld█-----$rst$f5█$rst  $f6$bld█-----$rst$f6█$rst
  $f1$bld█---$rst$f1█$rst    $f2$bld█---$rst$f2█$rst    $f3$bld█---$rst$f3█$rst    $f4$bld█---$rst$f4█$rst    $f5$bld█---$rst$f5█$rst    $f6$bld█---$rst$f6█$rst
   $f1$bld█-$rst$f1█$rst      $f2$bld█-$rst$f2█$rst      $f3$bld█-$rst$f3█$rst      $f4$bld█-$rst$f4█$rst      $f5$bld█-$rst$f5█$rst      $f6$bld█-$rst$f6█$rst
    $f1$bld█$rst        $f2$bld█$rst        $f3$bld█$rst        $f4$bld█$rst        $f5$bld█$rst        $f6$bld█$rst
   $f1█-$bld█$rst      $f2█-$bld█$rst      $f3█-$bld█$rst      $f4█-$bld█$rst      $f5█-$bld█$rst      $f6█-$bld█$rst
  $f1█---$bld█$rst    $f2█---$bld█$rst    $f3█---$bld█$rst    $f4█---$bld█$rst    $f5█---$bld█$rst    $f6█---$bld█$rst
 $f1█-----$bld█  $rst$f2█-----$bld█$rst  $f3█-----$bld█$rst  $f4█-----$bld█$rst  $f5█-----$bld█$rst  $f6█-----$bld█$rst
  $f1█---$bld█$rst    $f2█---$bld█$rst    $f3█---$bld█$rst    $f4█---$bld█$rst    $f5█---$bld█$rst    $f6█---$bld█$rst
  $f1 █-$bld█$rst     $f2 █-$bld█$rst     $f3 █-$bld█$rst     $f4 █-$bld█$rst     $f5 █-$bld█$rst     $f6 █-$bld█$rst
    $f1█$rst        $f2█$rst        $f3█$rst        $f4█$rst        $f5█$rst        $f6█$rst
   $f1$bld█-$rst$f1█$rst      $f2$bld█_$rst$f2█$rst      $f3$bld█-$rst$f3█$rst      $f4$bld█-$rst$f4█$rst      $f5$bld█-$rst$f5█$rst      $f6$bld█-$rst$f6█$rst
  $f1$bld█---$rst$f1█$rst    $f2$bld█---$rst$f2█$rst    $f3$bld█---$rst$f3█$rst    $f4$bld█---$rst$f4█$rst    $f5$bld█---$rst$f5█$rst    $f6$bld█---$rst$f6█$rst
 $f1$bld█-----$rst$f1█$rst  $f2$bld█-----$rst$f2█$rst  $f3$bld█-----$rst$f3█$rst  $f4$bld█-----$rst$f4█$rst  $f5$bld█-----$rst$f5█$rst  $f6$bld█-----$rst$f6█$rst
  $f1$bld█---$rst$f1█$rst    $f2$bld█---$rst$f2█$rst    $f3$bld█---$rst$f3█$rst    $f4$bld█---$rst$f4█$rst    $f5$bld█---$rst$f5█$rst    $f6$bld█---$rst$f6█$rst
   $f1$bld█-$rst$f1█$rst      $f2$bld█-$rst$f2█$rst      $f3$bld█-$rst$f3█$rst      $f4$bld█-$rst$f4█$rst      $f5$bld█-$rst$f5█$rst      $f6$bld█-$rst$f6█$rst
    $f1$bld█$rst        $f2$bld█$rst        $f3$bld█$rst        $f4$bld█$rst        $f5$bld█$rst        $f6$bld█$rst
   $f1█-$bld█$rst      $f2█-$bld█$rst      $f3█-$bld█$rst      $f4█-$bld█$rst      $f5█-$bld█$rst      $f6█-$bld█$rst
  $f1█---$bld█$rst    $f2█---$bld█$rst    $f3█---$bld█$rst    $f4█---$bld█$rst    $f5█---$bld█$rst    $f6█---$bld█$rst
 $f1█-----$bld█  $rst$f2█-----$bld█$rst  $f3█-----$bld█$rst  $f4█-----$bld█$rst  $f5█-----$bld█$rst  $f6█-----$bld█$rst

EOF
}
