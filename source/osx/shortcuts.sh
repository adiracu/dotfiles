
# os x doesn't have -F
psef () { ps -ef $@ ; }

alias ls='ls -G'

alias killmouseacc='defaults write .GlobalPreferences com.apple.mouse.scaling -1'


opensublime ()
{
    /usr/bin/open "$@" -a "Sublime Text"
}



sopcastToVlc ()
{
   if test $# -eq 0 ; then
     echo "sopcastToVlc sopcast_channel port_to_foward_to"
     return
   fi
   echo "now open vlc and stream from http://localhost:$2"

   /Applications/SopCast.app/Contents/Resources/binaries/m32/sp-sc-auth sop://broker.sopcast.com:3912/$1 3908 $2 > /dev/null
}

postnotification ()
{

	terminal-notifier -message "${1}" -title "${2}"
}


