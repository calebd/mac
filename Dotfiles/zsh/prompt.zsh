cmd_prompt_red_color() {
	echo "%{$fg[red]%}"
}
cmd_prompt_reset_color() {
	echo "%{$reset_color%}"
}
cmd_prompt_xcode_name() {
	workspace="$(ls | grep '.*\.xcworkspace$' | cut -d '.' -f1)"
	if [ -n "$workspace" ]; then
		echo "$workspace"
		return;
	fi
	
	project="$(ls | grep '.*\.xcodeproj$' | cut -d '.' -f1)"
	if [ -n "$project" ]; then
		echo "$project"
		return;
	fi
	
	directory="$(basename $PWD)"
	echo "$directory"
}
cmd_prompt_git_branch() {
  if [ ! git ls-files >& /dev/null ]; then
		return;
  fi;
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " (${ref#refs/heads/})"
}

PROMPT='$(cmd_prompt_red_color)$(cmd_prompt_xcode_name)$(cmd_prompt_git_branch) -> $(cmd_prompt_reset_color)'