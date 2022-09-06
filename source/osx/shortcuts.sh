

opensublime ()
{
    /usr/bin/open "$@" -a "Sublime Text"
}


postnotification ()
{

	terminal-notifier -message "${1}" -title "${2}"
}


