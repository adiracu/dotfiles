

NOT_YET_DONE="Not overwritten by OS specific function"
# Typos / Shortcuts

alias ll='ls -l'
alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias grpe='grep'

alias jobs='jobs -l'

# overwritten by osx
alias psef='ps -eF'

psefgrep()
{
if psef | grep $1 &>/dev/null ; then
	psef | head -n 1
	psef | grep $1
fi
}



# APP SHORTCUTS
opensublime () { echo -n "$NOT_YET_DONE" }


# Calculator
calc() { echo "scale=4;$1" | bc ; }

convertDecToHex() { echo "obase=16; ibase=10; $1" | bc ; }
convertDecToBin() { echo "obase=2 ; ibase=10; $1" | bc ; }
convertHexToDec() { echo "obase=10; ibase=16; $1" | bc ; }
convertHexToBin() { echo "obase= 2; ibase=16; $1" | bc ; }
convertBinToDec() { echo "obase=10; ibase= 2; $1" | bc ; }
convertBinToHex() { echo "obase=16; ibase= 2; $1" | bc ; }

# File System

extension() { echo ${1##*.} ; }
size() { du -c -h $1 | grep total ; }


# GIT/SVN
alias countgitcommits='git log --pretty=format:'' | wc -l'
gitcommit()  { git commit -a -m "$1" ; }

svnreposize() { svn list -vR $1 | awk '{tmp=match($3,/[0-9]/);if(tmp){sum+=$3; i++}} END {print "\ntotal size= " sum/1024000" MB" "\nnumber of files= " i/1000 " K"}' ;  }


# SSH
sshnopub() { ssh -o PubkeyAuthentication=no $1 ; }


# useful little ones
sha1oftext() { echo -n $1 | sha1sum | awk '{print toupper($1)}' ; }
md5oftext()  { echo -n $1 | md5sum  | awk '{print toupper($1)}' ; }
