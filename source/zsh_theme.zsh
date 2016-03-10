# [user@host curr_folder] $  .......  <:(> <git status> HH:MM
#  <:(> appears if the last exit code was non zero
#  <git status> appears if the current dir is in a git repo
#  host appears in red if this is a ssh session


# Function Declaration

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}+"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

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
	   else
	    	__CURRENT_GIT_BRANCH_IS_DIRTY='0'
	 	fi

	 	if test ${__CURRENT_GIT_BRANCH_IS_DIRTY} = '1' ; then
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

# %n - username
# %m - host up to the first .
# %c - the current path, shortened

# Conditional substring
# %(x.true-text.false-text)
   #   !      True if the shell is running with privileges.
   #   #      True if the effective uid of the current process is n.
   #   ?      True if the exit status of the last command was n.
   #   _      True if at least n shell constructs were started.
   #   C
   #   /      True if the current absolute path has at least n elements
   #          relative to the root directory, hence / is counted  as  0
   #          elements.
   #   c
   #   .
   #   ~      True if the current path, with prefix replacement, has at
   #          least n elements relative to the root directory, hence  /
   #          is counted as 0 elements.
   #   D      True if the month is equal to n (January = 0).
   #   d      True if the day of the month is equal to n.
   #   g      True if the effective gid of the current process is n.
   #   j      True if the number of jobs is at least n.
   #   L      True if the SHLVL parameter is at least n.
   #   l      True  if  at least n characters have already been printed
   #          on the current line.
   #   S      True if the SECONDS parameter is at least n.
   #   T      True if the time in hours is equal to n.
   #   t      True if the time in minutes is equal to n.
   #   v      True if the array psvar has at least n elements.
   #   V      True  if  element  n  of  the  array  psvar  is  set  and
   #          non-empty.
   #   w      True if the day of the week is equal to n (Sunday = 0).

__IS_CURR_DIR_GIT='0'

__SMILEY_FACE="%(?,,:( %?)"
__TIME="%T"
# Before each command
function precmd() {
   if test ${__IS_CURR_DIR_GIT} = '1' ; then
      # git info
      RPROMPT='${__SMILEY_FACE} $(git_prompt_info) ${__TIME}'
   else
      # sad smiley + time
      RPROMPT="${__SMILEY_FACE} ${__TIME}"
   fi
}

# Changing directory
function chpwd () {
   local st="$(git status 2>/dev/null)"
   if [[ -n "$st" ]]; then
      __IS_CURR_DIR_GIT='1'
   else
      __IS_CURR_DIR_GIT='0'
   fi
}

USER="%{$fg[cyan]%}%n"

# having %m doesn't work on my mac for some reason
hostname=`hostname`
hostname=${hostname%%.*}
# hostame="%m"

if test -n "${SSH_TTY}" -o -n "$SSH_CLIENT" ; then
	HOST="%{$bg[red]%}%{$fg[white]%}${hostname}"
else
	HOST="${hostname}"
fi
CURR_DIR="%{$fg[yellow]%}%c"
PRIVILIGES="%(!,#,$)"


PROMPT="[%{$reset_color%}${USER}@${HOST}%{$reset_color%} ${CURR_DIR}%{$fg[cyan]%}]${PRIVILIGES}%{$reset_color%} "

# fake a ch pwd so that the current git status is read and drawn if necessary
chpwd
