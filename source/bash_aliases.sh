# Universal aliases and functions
NOT_OW_YET=" Not overwritten by os specific action. "


# Useful shortcuts/typos
alias ll='ls -l'
alias grpe="grep"

# this needs to be overwritten on OSX, as there is no -F
alias psef="ps -eF"

alias ls='ls --color=auto'
alias grep="grep --color"
alias jobs='jobs -l'


# psef
psefgrep() {
	if psef | grep $1 &>/dev/null ; then
		psef | head -n 1
		psef | grep $1
	fi

# App open shortcuts
function opensublime() { echo "${NOT_OW_YET}"  }
alias packagesBySize="echo ${NOT_OW_YET}"

# Calculator
convertDecToHex() { echo "obase=16; ibase=10; $1" | bc ; }
convertDecToBin() { echo "obase=2 ; ibase=10; $1" | bc ; }
convertHexToDec() { echo "obase=10; ibase=16; $1" | bc ; }
convertHexToBin() { echo "obase= 2; ibase=16; $1" | bc ; }
convertBinToDec() { echo "obase=10; ibase= 2; $1" | bc ; }
convertBinToHex() { echo "obase=16; ibase= 2; $1" | bc ; }

# Find out the extension of a file
extension() { echo ${1##*.} ; }



# File System
size() { du -c -h $1 | grep total ; }

# Git
alias countgitcommits='git log --pretty=format:'' | wc -l'



# SSH
sshnopub() { ssh -o PubkeyAuthentication=no $1 ; }

# MISC
sha1oftext() { echo -n $1 | sha1sum | awk '{print toupper($1)}' ; }
md5oftext()  { echo -n $1 | md5sum  | awk '{print toupper($1)}' ; }

