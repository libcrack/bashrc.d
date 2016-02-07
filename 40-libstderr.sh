# https://github.com/sickill/stderred
if [[ -n "${LIBSTDERR}" ]]; then
    LIBSTDERR_SO="${HOME}/.local/lib/libstderred.so"
    if [[ -f "${LIBSTDERR_SO}" ]]; then
        export LD_PRELOAD="${LIBSTDERR_SO}${LD_PRELOAD:+:$LD_PRELOAD}"
    else
        error "Cannot find ${LIBSTDERR}"
    fi
fi
