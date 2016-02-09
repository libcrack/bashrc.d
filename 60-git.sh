# Author: devnull@libcrack.so
# Date: Sat Jan 10 11:26:32 CET 2015
# Description: GIT helpers

myself="$(readlink -m ${0#-*})"
mydir="$(dirname "${myself}")"

# git completion
[[ -f /usr/share/git/git-prompt.sh ]] && . /usr/share/git/git-prompt.sh
[[ -f ${mydir}/??-git-prompt.sh ]] && . ${mydir}/??-git-prompt.sh

# git-run
which gr > /dev/null 2>&1 && . <(gr completion)

#GIT_REPOS=$(find "${GIT_REPOS_HOME}" -name .git -exec dirname {} \; | egrep -iv "${GIT_REPOS_IGNORE}")
#GIT_REPOS=$(find "${GIT_REPOS_HOME}" -name .git -type d | grep -v ^./.git)
export GIT_REPOS="${HOME}/repos"
export GIT_REPOS_HOME="${HOME}/repos"
export GIT_REPOS_IGNORE="alienvault|os-sim|pfsense-tools|linux|jennylab"

gitc()
{
    git clone ${@}
}

_git_all_update_repos()
{
   export  GIT_REPOS=$(find "${GIT_REPOS_HOME}" \
       -name .git -exec dirname {} \; \
       | egrep -iv "${GIT_REPOS_IGNORE}")
}

__git_parse_branch()
{
   #git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
   #git branch 2> /dev/null | grep -e ^* | sed -E s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /
   #git branch 2> /dev/null | grep -e ^* | sed -E 's|^\*\ (.+)$|(\1)|'
   #git branch 2>/dev/null | sed -E 's|^\*\ (.+)$|(\1)|'
   git branch 2>/dev/null | sed -E 's/^\*\ (.+)$/(\1)/'
}

git_all_submodule()
{
    for mod in ${GIT_REPOS}; do
        dir=$(dirname $mod)
        url=$(grep url $mod/config | cut -f2 -d=)
        #echo rm -rf $dir
        echo cd $(realpath $(dirname $dir))
        echo git submodule add $url
    done
}

git_all_list()
{
    _git_all_update_repos
    echo -e "[$RED*$RESET] exported GIT repos:"
    for r in ${GIT_REPOS};
        do echo -e "\t$RED*$RESET $r"
    done
}

git_all_pull()
{
    _git_all_update_repos
    local back=$PWD
    for repo in ${GIT_REPOS}; do
        echo -e "\n[$RED*$RESET] PULLING $(basename $repo)";
        cd $repo && git pull;
    done;
    cd $back
}

git_all_pull_branches()
{
    _git_all_update_repos
    local back=$PWD
    for repo in ${GIT_REPOS}; do
        echo -e "[*] PULLING $(basename $repo)\n";
        cd $repo
        for branch in $branches; do
            git checkout $branch && git pull;
        done;
    done;
    cd $back
}

git_all()
{
    test -z "$1" \
        && echo -e "\n\t>> ${RED}ERROR${RESET} ${FUNCNAME}: I need a git action (pull,status,push,etc)\n" \
        && return
    opwd=$(pwd)
    count=0
    local dirs=$(find . -type d -name .git -exec dirname {} \;)
    for d in $dirs; do
        if [ -d $d ]; then
            cd $d
            blue "\n>> [$FUNCNAME $@ $d]\n"
            git $@ && let count++
            cd $opwd
        fi
    done
    blue ">> $count repos reached"
}

git_rename_author()
{
    git filter-branch --env-filter '
        GIT_AUTHOR_NAME="Borja";
        GIT_AUTHOR_EMAIL="<devnull@libcrack.so>";
        GIT_COMMITTER_NAME="Borja";
        GIT_COMMITTER_EMAIL="<devnull@libcrack.so>";
    ' -- --all
}

git_add_all_submodules()
{
    test -z "$1" && dir=.
    repos="$(find $dir -name .git -type d -exec grep url {}/config \; | awk '{print $3}')"
    for r in $repos; do
        #rm -rf "$(realpath -m $r)"
        echo -e "[*] Submodule \e[31m$r\e[0m"
        git submodule add "$r" && git fetch origin --tags && git checkout master && git pull
    done
}

# jdelacasa
function git-check() {

    l_hlt="\033[32;40m"
    l_nor="\033[34m"
    l_maj="\033[41;37m"
    l_rst="\033[0m"

    l_git_branch=$(git branch 2>/dev/null|awk '$1 == "*" {print $2}')

    if [[ ${l_git_branch} != "" ]]; then
     if [[ ${l_git_branch} == "master" ]]; then
        l_git_branch="${l_maj}${l_git_branch}${l_hlt}"
     else
        l_git_branch="${l_nor}${l_git_branch}${l_hlt}"
     fi
     l_git_sha1=$(git branch --verbose 2>/dev/null|awk '$1 == "*" {print $3}')
     git status 2>&1 | grep "working directory clean" >/dev/null
     if [[ $? -ne 0 ]]; then
        l_git_sha1="${l_maj}${l_git_sha1}${l_hlt}"
        l_chg=" *** You have uncommitted changes ***"
     else
        l_git_sha1="${l_nor}${l_git_sha1}${l_hlt}"
        l_chg=""
     fi
     printf "\n${l_hlt} BRANCH: ${l_git_branch} (${l_git_sha1})${l_chg} ${l_rst} \n$"
    fi

}
# PS1="$PS1 \$(git-check)"

