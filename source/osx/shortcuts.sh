
# os x doesn't have -F
alias psef='ps -ef'

alias ls='ls -G'

alias killmouseacc='defaults write .GlobalPreferences com.apple.mouse.scaling -1'


opensublime ()
{
    /usr/bin/open "$@" -a "Sublime Text 2"
}



sopcastToVlc ()
{
    /Applications/SopCast.app/Contents/Resources/binaries/m32/sp-sc-auth $1 $2 8902 > /dev/null
}

