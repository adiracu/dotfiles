# ZSH Theme based on doubleend

# Function Declaration

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
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

  # echo "LEN PWD IS $lenPwd"
  local spacing=""
  for i in {1..$termwidth}; do
    spacing="${spacing} "
  done
  echo $spacing
}

function precmd() {

# if test -n "${SSH_TTY}" -o -n "$SSH_CLIENT" ; then
# print -rP '
# $fg[cyan]%n@$bg[red]$fg[white]%m%{$reset_color%}$fg[cyan]: $fg[yellow]$(get_pwd)$(put_spacing)$(git_prompt_info)'
# else

	print -rP '
$fg[cyan]%n@%m: $fg[yellow]$(get_pwd)$(put_spacing)$(git_prompt_info)'

# fi

}


# Customising the prompt

PROMPT='%{$reset_color%}→ '
# RPROMPT='%T'


ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
