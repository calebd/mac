x() {
  local project="$(ls | grep '.*\.xcworkspace$')"
  [[ -z $project ]] && project="$(ls | grep '.*\.xcodeproj$')"
  [[ -n $project ]] && open $project
}
