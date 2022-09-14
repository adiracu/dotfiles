NOT_YET_DONE="Not overwritten by OS specific function"

# Path
export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/Contents/Home

# Typos / Shortcuts

alias ll='ls -lh'
alias clear='echo "Use CTRL+L"'


alias grep='grep --color=auto'
alias grpe='grep'
alias grepexclude='grep --color=auto --exclude-dir={".svn",".metadata",".git"}'

# man
mansearch () {    # Bash
    local pages string
    if test $# -ne 2; then
    	echo "Usage:  mansearch page_name  regex_to_search_for"
    	return;
    fi
    pages=(${@:1})
    string="$2"

    man -P "less -p \"$string\" " ${pages[@]}
}

# APP SHORTCUTS
sub () { echo -n "$NOT_YET_DONE" ; }

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


# useful little ones
sha1oftext() { echo -n $1 | sha | awk '{print toupper($1)}' ; }
md5oftext()  { echo -n $1 | md5  | awk '{print toupper($1)}' ; }

function beep() { echo -e "\a" }

        local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))

function startTimerInSeconds
{
        local SECONDS=$((  $1  ))
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
        beep
        postnotification "Timer $1 finished." "Timer Finished"
}

function startTimerInMinutes
{
        local SECONDS=$((  ($1 * 60)  ))
        startTimerInSeconds $SECONDS
}

function startRepeatingTimerInSeconds
{
        while true 
        do
                startTimerInSeconds $1
        done
}

