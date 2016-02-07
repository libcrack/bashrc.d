# Go programming
export GOROOT="${HOME}/go"
export GO_HOME="${GOROOT}"
[[ -d "${GO_HOME}/bin" ]] \
  && export PATH="${GO_HOME}/bin:${PATH}"
