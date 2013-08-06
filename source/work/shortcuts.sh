

opensublime ()
{
    /usr/local/sublime-text-2/sublime_text "$@"
}


# mount an smb share
mountsmbfromto() { sudo /bin/mount -t cifs -o username=aracu,domain=ad-01.ent-01.adgroup $1 $2 ; }

# SSH

alias sshtestcomp='ssh adrian@testcomp'
scptotestcomp() { scp $1 adrian@testcomp:~ ; }
scptotestcompscripts() { scp $1 adrian@testcomp:~/scripts/ ;  }


copytowinshare() { cp $1 /home/adi/Documents/vm_win_xp3/vmShare/ ; }

