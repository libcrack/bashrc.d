# Decription: Betty, the poor's main Siri <https://github.com/pickhardt/betty>
BETTY_HOME="${HOME}/betty"

betty(){
    [[ -f "${BETTY_HOME}/main.rb" ]] && {
        success "BETTY_HOME=${BETTY_HOME}/main.rb found"
        exec "${BETTY_HOME}/main.rb" "${@}" &
    } || {
        error "Cannot find betty: BETTY_HOME=${BETTY_HOME}"
        error "Fix: git clone https://github.com/pickhardt/betty ${BETTY_HOME}"
        return 1
    }
    return $?
}
