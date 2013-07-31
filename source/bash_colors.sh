#!/bin/bash


# Bash primarily uses 2 variables to define how the prompt looks like:
# PS1 - specifies the format of the prompt that appears to the left of cmd
# PS2 - the continuation prompt; when you enter multiple lines (at end\)
#

# man bash and search for PROMPTING to see list of variables
# \h - hostname, up to the first '.'
# \W - basename of pwd; $HOME is shown as a ~
# \u - username of curr user
# \$ - effective uid (# or $; root or normal user)

# Assign a default value
THEME_TO_USE="--theme=reset"

if test "${SSH_TTY}"; then
	THEME_TO_USE="--theme=ssh"
fi


if test $# -ge "1"; then
	if test $1 == "--help" ; then
		echo "Valid options are [--theme={reset | ssh | none}]"
		echo "      : reset   - assumes a black blackground; everything is emphasized "
		echo "      : ssh     - color the in background red"
		echo "                - useful if the you're sshing in the machine a lot"
		echo "      : none    - no coloring"
		echo ""
		echo "The default theme used is:"
		echo "      - if \$SSH_TTY is set, 'ssh'"
		echo "      - otherwise, 'reset'"
	elif test $1 == "--theme=reset" -o $1 == "--theme=ssh" -o $1 == "--theme=none"; then
		THEME_TO_USE=$1
	fi
fi

# e.g. [adi@adismachine ~]$


# Kinda appears like a really light gray
COLOR_EMPH="\[\033[2m\]"
COLOR_LIGHT_GRAY="\[\033[0;37m\]"
COLOR_RED="\[\033[0;41m\]"
COLOR_OFF="\[\033[0m\]"

COLOR_EVERYTHING=${COLOR_OFF}
COLOR_HOSTNAME=${COLOR_OFF}

case "${THEME_TO_USE}" in
	"--theme=reset")
		COLOR_EVERYTHING=${COLOR_EMPH}
		COLOR_HOSTNAME=${COLOR_EMPH}
	;;
	"--theme=ssh")
		COLOR_EVERYTHING=${COLOR_EMPH}
		COLOR_HOSTNAME=${COLOR_RED}
	;;
	"--theme=none")
		COLOR_EVERYTHING=${COLOR_OFF}
		COLOR_HOSTNAME=${COLOR_OFF}
	;;
esac


export PS1="${COLOR_EVERYTHING}[\u@${COLOR_OFF}${COLOR_HOSTNAME}\h${COLOR_OFF}${COLOR_EVERYTHING} \W]\$${COLOR_OFF}"
export PS2="${COLOR_LIGHT_GRAY}>${COLOR_OFF}"

