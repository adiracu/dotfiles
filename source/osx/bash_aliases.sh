#OS X Specific aliases



# Kills the mouse accelerations
alias killmouseacc='defaults write .GlobalPreferences com.apple.mouse.scaling -1'


# Ovewritting
alias psef="ps -ef"

function opensublime() { /usr/bin/open "$@" -a "Sublime Text 2"; }

sopcastToVlc() { /Applications/SopCast.app/Contents/Resources/binaries/m32/sp-sc-auth $1 $2 8902 > /dev/null ; }

