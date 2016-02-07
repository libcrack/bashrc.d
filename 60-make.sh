# Author: devnull@libcrack.so
# Date: Sat Jan 10 11:26:32 CET 2015
# Description: Make compilation wrapper

# CPPFLAGS="-D_FORTIFY_SOURCE=2"
# CXXFLAGS="-march=native -O2 -pipe -fstack-protector-strong --param=ssp-buffer-size=4"
# LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,--hash-style=gnu"

make() {
  local red=$(echo -e "\e[1;31m")
  local yel=$(echo -e "\e[1;33m")
  local rst=$(echo -e "\e[0;00m")

  /usr/bin/make "${@}" 2>&1 \
    | sed -e "s/[Ee]rror:/${red}&${rst}/g" \
      -e "s/[Ww]arning:/${yel}&${rst}/g"

  return ${PIPESTATUS[0]}
}

