



function opensublime() { sublime_text "$@" ; }


alias packagesBySize="pacman -Qi | egrep \"Name|Installed Size\" | sed -e \'N;s/\n/ /\' | awk \'{ print $7, $3}\' | sort -n"
