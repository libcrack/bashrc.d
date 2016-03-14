# devnull@libcrack.so
# lun mar 14 05:30:07 CET 2016

export NFS="/mnt/nfs/borja"
export NFS_DIRS=()

nfs-overlay-discover(){
    mount | grep -q "${NFS}" || die "Not mounted: ${NFS}"
    for i in "${HOME}"/*; do
        if [[ -h "${i}" && -d "${i}" ]]; then
            if [[ "$(realpath "${i}")" =~ "$(dirname "${NFS}")" ]]; then
                if [[ ! ${NFS_DIRS[@]} =~ $(basename "${i}") ]]; then
                    NFS_DIRS="${NFS_DIRS[@]} $(basename "${i}")"
                    echo "${i}"
                fi
            fi
        fi
    done
}

nfs-overlay-enable(){
    nfs-overlay-discover
    for i in ${NFS_DIRS[@]}; do
        if [[ -d "${NFS}/${i}" \
        && ! -e "${HOME}/${i}" ]]; then
            ln -s "${NFS}/${i}" "${HOME}/${i}"
        fi
    done
}

nfs-overlay-disable(){
    for i in ${NFS_DIRS[@]}; do
        if [[ -h "${i}" && -d "${i}" ]]; then
            if [[ "$(realpath "${i}")" =~ "${NFS}" ]]; then
                rm "${HOME}/${i}"
            fi
        fi
    done
}

