# sanitize TERM
sanitize_term(){
  safe_term=${TERM//[^[:alnum:]]/?}
  match_lhs=""
}

# read a stream from stdin and escape characters
# in text that could be interpreted as special
# characters by sed

escapestr_sed() {
 sed \
  -e 's/\//\\\//g' \
  -e 's/\&/\\\&/g'
}
