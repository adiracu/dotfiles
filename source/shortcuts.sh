NOT_YET_DONE="Not overwritten by OS specific function"
# Typos / Shortcuts

alias ll='ls -l'
alias clear='echo "Use CTRL+L"'

# OSX doesnt have this..
alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias grpe='grep'
alias grepexclude='grep --color=auto --exclude-dir=".svn" --exclude-dir=".svn" --exclude-dir=".metadata" --exclude-dit=".git"'

alias jobs='jobs -l'

# overwritten by osx; needs to be a function because it's used in psefgrep
#   with just an alias, it get replaced to -eF even for osx
psef () { ps -eF $@ ; }

# man
manjump () {    # Bash
    local pages string
    if test $# -ne 2; then
    	echo "Usage:  manjump  regex_to_search_for  page_name"
    	return;
    fi
    pages=(${@:2})
    string="$1"

    man -P "less -p \"$string\" " ${pages[@]}
}

psefgrep()
{
if psef | grep $@ &>/dev/null ; then
	psef | head -n 1
	psef | grep $@
fi
}

# APP SHORTCUTS
opensublime () { echo -n "$NOT_YET_DONE" ; }

    # TWO ARGUMENTS; message and title
postnotification () { echo -n "$NOT_YET_DONE" ; }

# Calculator
calc() { echo "scale=4;$1" | bc ; }

convertDecToHex() { echo "obase=16; ibase=10; $1" | bc ; }
convertDecToBin() { echo "obase=2 ; ibase=10; $1" | bc ; }
convertHexToDec() { echo "obase=10; ibase=16; $1" | bc ; }
convertHexToBin() { echo "obase=2 ; ibase=16; $1" | bc ; }
convertBinToDec() { echo "obase=10; ibase= 2; $1" | bc ; }
convertBinToHex() { echo "obase=16; ibase= 2; $1" | bc ; }

# File System

extension() { echo ${1##*.} ; }
size() { du -c -h $1 | grep total ; }


# GIT/SVN
alias countgitcommits='git log --pretty=format:'' | wc -l'

alias gstat='git status'
gcomm() { git commit -m "$1" ; }
gcommall() { git commit -a -m "$1" ; }
gadd() { git add "$@" ; }

svnreposize() { svn list -vR $1 | awk '{tmp=match($3,/[0-9]/);if(tmp){sum+=$3; i++}} END {print "\ntotal size= " sum/1024000" MB" "\nnumber of files= " i/1000 " K"}' ;  }


# SSH
sshnopub() { ssh -o PubkeyAuthentication=no $1 ; }

# useful little ones
sha1oftext() { echo -n $1 | sha1sum | awk '{print toupper($1)}' ; }
md5oftext()  { echo -n $1 | md5sum  | awk '{print toupper($1)}' ; }


function countdown
{
        local OLD_IFS="${IFS}"
        IFS=":"
        local ARR=( $1 )
        local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))
        local START=$(date +%s)
        local END=$((START + SECONDS))
        local CUR=$START

        while [[ $CUR -lt $END ]]
        do
                CUR=$(date +%s)
                LEFT=$((END-CUR))

                printf "\r%02d:%02d:%02d" \
                        $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60))

                sleep 1
        done
        IFS="${OLD_IFS}"
        echo "        "
        postnotification "Timer $1 finished." "Timer Finished"
}


