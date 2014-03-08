# added for brew
export PATH=/usr/local/bin:$PATH

if test -n "$BASH_VERSION" ; then
	if test -f ~/.bashrc ; then
        . ~/.bashrc
    fi
fi
