
dockerctl() {
    case "$1" in
        viper)     docker run --rm -it -v ~/viper:/home/nonroot/workdir remnux/viper ;;
        pescanner) docker run --rm -it -v ~/viper:/home/nonroot/workdir remnux/pescanner bash ;;
        masstiff)  docker run --rm -it -v ~/viper:/home/nonroot/workdir remnux/masstiff ;;
        build)
            [[ -z "$2" ]] && echo "Usage: ${FUNCNAME} build <tagname>" && return 1
            docker build --tag="$2" --rm=true .
        ;;
        run)
            [[ -z "$2" ]] && echo "Usage: ${FUNCNAME} run <tagname>" && return 1
            docker run --interactive=true --tag="$2" "/bin/bash"
        ;;
        ps) docker ps --no-trunc --all ;;
        img) docker images --no-trunc --all ;;
        clean)
            case "$2" in
                ps)       docker ps --all --quiet | xargs docker rm -f ;;
                images)   docker images --all --quiet | xargs docker rmi -f ;;
                dangling) docker images --all --quiet --filter "dangling=true" | xargs docker rmi -f ;;
                *) echo "Usage: ${FUNCNAME} clean <ps|images|dangling>" ;;
            esac
        ;;
       *)
            echo "Usage: ${FUNCNAME} <ps|images|clean>"
        ;;
    esac
}
_complete_dockerctl(){
    COMPREPLY=()
    local cur prev opts word
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="build clean help images ps run viper pescanner masstiff"

    if [[ "${prev}" == "clean" ]]; then
        opts="ps images dangling"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}))
        return 0
    elif [[ "${prev}" == "build" ]]; then
        opts="tagname"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}))
        return 0
    elif [[ "${prev}" == "run" ]]; then
        opts="tagname"
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}))
        return 0
    fi

    if [[ "${cur}" == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi

    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )

}
complete -F _complete_dockerctl dockerctl

alias dockviz="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock nate/dockviz"
alias docker_ps_clean='docker ps --no-trunc --all'
alias dockerps='docker ps --no-trunc --all | grep Exited | awk "{print \$1}"'
alias dockerrm='docker rm -f `dockerps`'
alias dockerimg='docker images --no-trunc --all | grep $1 | awk "{print \$3}"'
alias dockerrmi='docker rmi -f `dockerimg`'

#dockviz(){
#  local repo='nate/dockviz'
#  local sock='/var/run/docker.sock'
#  echo docker run --rm -v "$sock":"$sock" "$repo"
#}

docker-bench-security() {
    local name="docker-bench-security"
    local repo="https://github.com/docker/${name}.git"

    # [[ -d "$name" ]] || git clone "$repo"
    # cd "$name"

    echo docker pull docker/"$name"

    echo docker run -it \
        --net host \
        --pid host \
        --label "$name" \
        --cap-add audit_control \
        -v /var/lib:/var/lib \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v /usr/lib/systemd:/usr/lib/systemd \
        -v /etc:/etc \
        "docker/$name"

    return $?
}

docker-irssi(){
    docker run --rm=true -it \
        -e TERM -u "$(id -u):$(id -g)" \
        -v /etc/localtime:/etc/localtime  \
        -v "${HOME}/.irssi:/home/user/.irssi" \
        --read-only  \
        --name irssi \
        irssi
}

dockerpsa(){
    local fmt="table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.Status}}\t{{.Names}}"
    docker ps --all --format "$fmt"
}

