# ZSH Theme based on doubleend

# Function Declaration
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

function git_prompt_info() {
  	# ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  	# echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"

  	result=""

	local st="$(git status 2>/dev/null)"
	if [[ -n "$st" ]]; then
		local -a arr
	 	arr=(${(f)st})

		if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
	     __CURRENT_GIT_BRANCH='no-branch'
	 	else
	     __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
	 	fi

		__CURRENT_GIT_BRANCH_STATUS=
		__CURRENT_GIT_BRANCH_NO_COMMITS=
	 	if [[ $arr[2] =~ 'Your branch is' ]]; then
	     	if [[ $arr[2] =~ 'ahead' ]]; then
	         __CURRENT_GIT_BRANCH_STATUS="↑"
	         __CURRENT_GIT_BRANCH_NO_COMMITS="${arr[2]//[^0-9]/}"
	     	elif [[ $arr[2] =~ 'diverged' ]]; then
	         __CURRENT_GIT_BRANCH_STATUS="↕"
	         __CURRENT_GIT_BRANCH_NO_COMMITS="${arr[2]//[^0-9]/}"
	     	else
	         __CURRENT_GIT_BRANCH_STATUS="↓"
	         __CURRENT_GIT_BRANCH_NO_COMMITS="${arr[2]//[^0-9]/}"
	     	fi
	 	fi

	 	if [[ ! $st =~ 'nothing to commit' ]]; then
	     __CURRENT_GIT_BRANCH_IS_DIRTY='1'
	     echo "DIRTY"
	   else
	    	__CURRENT_GIT_BRANCH_IS_DIRTY=
	    	echo "CLEAN"
	 	fi

	 	if test -n __CURRENT_GIT_BRANCH_IS_DIRTY; then
	 		result+=$ZSH_THEME_GIT_PROMPT_DIRTY
	 	else
	 		result+=$ZSH_THEME_GIT_PROMPT_CLEAN
	 	fi

		result+=$ZSH_THEME_GIT_PROMPT_PREFIX
		result+=$__CURRENT_GIT_BRANCH
		result+=$__CURRENT_GIT_BRANCH_STATUS
		result+=$__CURRENT_GIT_BRANCH_NO_COMMITS
		result+=$ZSH_THEME_GIT_PROMPT_SUFFIX
	fi

	echo "$result"
}

function get_pwd() {
  basename `print -D $PWD`
}

function put_spacing() {
  local git=$(git_prompt_info)
  if [ ${#git} != 0 ]; then
  	# the 10 is for the colour codes that are also taken into consideration
    ((git=${#git} - 10))
  else
    git=0
  fi

  local termwidth
  # HOST%%.* - the host name up to the first . ; see %m in the PROMPT
  local lenHost="${#HOST%%.*}"
  local lenUser="${#USERNAME}"
  local lenPwd="${#$(get_pwd)}"
   # 3 for the @,: and <space>
  (( termwidth = ${COLUMNS} - 3 - ${lenUser} - ${lenHost} - ${lenPwd} - ${git} ))

  local spacing=""
  for i in {1..$termwidth}; do
    spacing="${spacing} "
  done
  echo $spacing
}

# Not using RPROMPT because I want the git prompt info on the same line as the other bits
#   RPROMPT would have put it on the line with the cmd
# Also, in precmd we can check the ssh session
function precmd() {

	if test -n "${SSH_TTY}" -o -n "$SSH_CLIENT" ; then
		print -rP '
$fg[cyan]%n@$bg[red]$fg[white]%m%{$reset_color%}$fg[cyan]: $fg[yellow]$(get_pwd)$(put_spacing)$(git_prompt_info)'
	else
		print -rP '
$fg[cyan]%n@%m: $fg[yellow]$(get_pwd)$(put_spacing)$(git_prompt_info)'

	fi
}

# Customising the prompt

PROMPT='%{$reset_color%}→ '

