x() {
  local project="$(ls | grep '.*\.xcworkspace$')"
  [[ -z $project ]] && project="$(ls | grep '.*\.xcodeproj$')"
  [[ -n $project ]] && open $project
}

c() {
  cd ~/Code/$1;
}

# Set Apple Terminal.app resume directory
# if [[ $TERM_PROGRAM == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]] {
#   function chpwd {
# 	local SEARCH=' '
# 	local REPLACE='%20'
# 	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
# 	printf '\e]7;%s\a' "$PWD_URL"
#   }
#   chpwd
# }
_set_terminal_location() {
  local SEARCH=' '
  local REPLACE='%20'
  local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
  printf '\e]7;%s\a' "$PWD_URL"
}
chpwd_functions+=(_set_terminal_location)
_set_terminal_location
