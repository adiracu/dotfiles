#!/bin/bash


function emph_it()   { echo -e "\033[0;36m$@\033[0m"; }

alias tips='
echo -e " Commands
`emph_it  "cal sept 1975"`   : quickly look up a calendar month
`emph_it "man {ascii|5 hosts.allow|7 regex}"` : useful man pages
`emph_it "xxd < file "`     : hexdump of file
`emph_it "xxd -i file"`     : hexdump in a C style var declaration
`emph_it "lsof"`            : shows open file handles, sockets etc.
`emph_it "iftop"`           : top for network; alternative `emph_it vnstat`
`emph_it "cd -"`            : cd to prev directory
`emph_it "tail -f file"`    : or can use `emph_it "less +F file"`
`emph_it "strace -ttT executable"`   : monitor OS calls for process
`emph_it "units"`           : convert units, interactive
`emph_it "mdfind"`          : uses spotlight on mac
`emph_it "cat /dev/dsp | ssh me@remotebox cat > /dev/dsp"` : pipe SSH; play audio remotely (cmd in quotes)
`emph_it "split -b1m binaryfile"`    : split file into megabyte chunks

 BASH built-ins
`emph_it "disown"`          : bash built-in, alternative to `emph_it nohup`
`emph_it "fc"`              : run the last command in \$EDITOR and run it afterwards
`emph_it "sudo !!"`         : !! is replaced with last command
`emph_it "^find^replace"`   : bash find/replace in last command

"'

# \"`emph_it {print \$1}`
alias awktips='
echo -e "`emph_it "echo Jones 123 | awk"` \"`emph_it \{print \$\1\}`\"    : prints Jones
`emph_it awk` \"`emph_it "BEGIN { FS = : } ; {print \$\2}"`\" : change the field separator
                                     : the new FS needs to be wrapped in quotes
"'

alias findtips='
echo -e "`emph_it "  -mindepth n"`      : do not apply any tests at levels less than n
`emph_it "  -maxdepth n"`      : descend at most n directory levels
`emph_it "  -name pattern"`    : true if the last component of the pathname matches pattern
                   : use quotes to escape shell expansion
`emph_it "  -iname pattern"`   : like `emph_it "name"`,but case insensitive
`emph_it "  -type [fdl]"`      : {file, directory, symbolic link}
`emph_it "  -perm  mode"`      : mode can be octal (`emph_it 644`) or symbolic (`emph_it -ug=w`)
`emph_it "  -size n[ckMGTP]"`  : {bytes, kilo, mega, giga, tera, peta}
                   : e.g. `emph_it -1K` (less than 1 kilo) or `emph_it +100M` (more than 100 megs)
`emph_it "  -mtime n"`         : (time last modified - time find started) < than n days; use with -
`emph_it "  -mmin n"`          : (time last modified - time find started) < than n minutes; use with -
`emph_it "  -newer aFile"`     : true if file has more recent last modification than aFile
                   : same as `emph_it -newermm`
`emph_it "  -newerXY aFile"`   : X,Y can be
                     : `emph_it a` - access time
                     : `emph_it B` - inode creation time
                     : `emph_it c` - change time
                     : `emph_it m` - modification time
                   : true if last X of file is more recent than Y of aFile
                   : if Y is `emph_it t`, then aFile is interpreted as a date

`emph_it "  -not expression"`  : NOT operator
`emph_it "  -exec utility [argument ..] {} \;"`    : execute utility for each path in part
`emph_it "  -exec utility [argument ..] {} \;"`    : same as before, but all paths are appended as arguments
                                       : same as using `emph_it "find | xargs utility [argument ..]"`
                                       : pipe to `emph_it xargs`; easier to remember


`emph_it "find . -not -name "`\"`emph_it \*.java`\" `emph_it "-maxdepth 4 -mtime -2"`
                   : all files not ending in .java, modified in the last 2 days
                   : descend at most 4 directory levels
`emph_it "find . -newermt "`\"`emph_it 2010-01-01`\"
                   : all files not ending in .java, modified in the last 2 days
`emph_it "find . -type f -newermt "`\"`emph_it 2013-01-01`\" `emph_it -not -newermt ` \"`emph_it 2013-06-01`\"
                   : all files that have their last modification date within 01-01-2013 and 06-01-2013
"'

# `find -mindepth 2 -maxdepth 2`
# `find -exec` : execute pe fiecare

alias gittips='


'


# git push --all ssh://adrianracu@noplanproductions.com/home/adrianracu/apps.noplanproductions.com/iTuneControl.git


alias greptips='
echo -e " `emph_it      grep options pattern file...`
`emph_it "   -A num"`                   : --after-context; print `emph_it num` of trailing lines after each match
`emph_it "   -B num"`                   : --before-context; print `emph_it num` of leading lines after each match
`emph_it "   -C num"`                   : --context; print `emph_it num` leading and trailing lines after each match
`emph_it "   --exclude-dir=\"pattern\" "`   : if -R is specified, it excludes directories matching the pattern from the search
`emph_it "   -e "`                      : --regexp; use it to specify multiple patterns
`emph_it "   -E "`                      : --extended-regexp, use extended regular expression. See `emph_it egrep`
`emph_it "   -i "`                      : --ignore-case
`emph_it "   -n "`                      : --line-number, output line preceded by line number
`emph_it "   -r "`                      : -R, --recursive, search recursively
`emph_it "   -v "`                      : --invert--match, all the lines that do not match
`emph_it "   -w "`                      : --word-regexp, the expression is search for as a word

`emph_it "grep -nr"` \"`emph_it new Foo\(\)`\" `emph_it src`    : search for instantiation of Foo and show line number
`emph_it "grep -e foo -e bar baz.txt "` : search for foo and bar in baz.txt
"'

alias killtips='
echo -e " `emph_it      kill -signal_number pid`
`emph_it "   -9 "`                   : KILL; do NOT use it; process cannot close sockets, clean up temp files etc.
Try and use
`emph_it "   -15"`                   : TERM; wait 2 seconds
"'


alias lsoftips='
echo -e " List open files
`emph_it "  lsof"`               : list all open files belonging to active processes
`emph_it "  -c nameStart"`  : only show processes whose names start with nameStart
`emph_it "  -u user"`       : only show processes whose user is user
`emph_it "  -u ^user"`      : only show processes whose user is not user
`emph_it "  -p PID"`        : only show process with PID

`emph_it "  lsof FILE"` : list processes that opened FILE(e.g. mount point)
`emph_it "   +D DIR"`   : list processes that opened files under DIR

"'


alias lstips='
echo -e "`emph_it "  -h"`              : print in human readable format
`emph_it "  -S"`              : sort by size
"'


alias mantips='
echo -e "`emph_it man 1-9 page_name`              : gets the page from that section

`emph_it "    -f word_to_search_for"`      : search in the NAMES of man pages
                               : useful if you can'\''t remember the exact name of a command
                               : same as `emph_it whatis word_to_search_for`
                               : useful :  `emph_it whatis -w *partial_name`

`emph_it "    -k word_to_search_for"`      : search in the NAMES and VERY SHORT DESCRIPTION of man pages
                               : use if you want to search for a command that does something
                               : same as `emph_it apropos word_to_search_for`

`emph_it "    -K word_to_search_for"`      : search for a string in all pages
                               : brute force
                               : it asks if it should open after each page it finds

`emph_it "    -s N -K word_to_search_for"` : specify sections to narow search

`emph_it "    -s N -K --regex REGEX"`      : use a regex

`emph_it manjump word_to_jump_to page`   : same as opening the page and searching for word

`emph_it zcat`                           : cat for man pages
"'

alias sedtips='
echo -e "
`emph_it "  -n"`                     : --quiet, disables auto printing of pattern space. To print, you must explicitly use `emph_it p`
`emph_it "  -f script_file"`         : sed command file follows
`emph_it "  -i[backup_extension] "`  : make in place and create a backup; e.g. `emph_it -i.bak Makefile`

`emph_it "/PAT_ON_LINE/s/PATT_TO_SEARCH/PAT_TO_REPLACE/g"` : search and replaces. PAT_ON_LINE is optional.
                                       : you can wrap parts of PATT_TO_SEARCH in () to use in the replace as \1 \2
`emph_it "/PAT_ON_LINE/d"`                : delete
`emph_it "/PAT_ON_LINE/p"`                : print
`emph_it "/PATTERN_START/,/PATTERN_END/"` : range from A to B
`emph_it "/PATTERN_START/,$"`             : just $ means EOF in sed
`emph_it "/PATTERN_START/,/$/"`           : $ means end of line in regex

`emph_it "...{}"`                         : only lines that matched whatever was before are processed inside the {}
                              : Equivalent to `emph_it sed` | `emph_it sed`
`emph_it "sed -n \"1,10p\""`                  : print lines from 1 to 10 sed starts from line 1
                              : no easy equivalent for `emph_it tail`

`emph_it "echo foo | sed"` \"s/foo/bar\"
`emph_it "stuff | xargs sed -i "` \"s/foo/bar\" : replace in place on each file passed
`emph_it find src/test -name` \"`emph_it \*Test.java`\" `emph_it "| xargs sed -i"` \"`emph_it s/Assert.assert/assert/`\"
                         : in all java test classes, replace Assert.assertStuff with assertStuff
`emph_it sed -i ` \"`emph_it /foo/ d`\" file    : delete lines containing foo
`emph_it sed -i ` \"`emph_it /\^\#/ d`\" file     : delete lines starting with #
`emph_it sed -i ` \"`emph_it 1,2 d`\" file      : delete first two lines
`emph_it sed -i ` \"`emph_it /\^\$/ d`\" file     : delete blank lines
`emph_it sed -i ` \"`emph_it 1,/\^\$/ d`\" file   : delete up to first blank line

Example script:
#!/usr/bin/sed -f
# -f means script file follows
# On all lines that match this
/GET \/announce/ {
  # Extract lines
  s/PAT_(TO)_(SEARCH)/\1 \2/g
  # actually print it, otherwise it will be supressed
  p
}

# deleting everything else that is not explicit from printing
# having it here, it works the same as passing -n as an arg, but this does not work in scripts
d
"'

alias sorttips='
echo -e "`emph_it "   -c file_to_check"`                      : --check if the file is sorted, reporting first exception otherwise
"'

alias sshtips='
echo -e "  Set up password-less login:
    1. ssh-keygen on machine A, if necessary
    2. create the .ssh directory structure on B, if needed
    3. check permissions on the .ssh structure on B :
        rwx------ (700)  .  (.ssh)
        rwxr-xr-x (755)  .. (~)
        rw------- (600)  authorized_keys

        This command (quotes needed) does 2&3:
`emph_it "       ssh user@remotebox test ! -d ~/.ssh && mkdir ~/.ssh ; chmod 700 ~/.ssh ; cd ~/.ssh ; test ! -f authorized_keys && touch authorized_keys ; chmod 600 authorized_keys"`
    4. copy the public key to B from A (add the quote for the cmd)
`emph_it "       cat ~/.ssh/id_rsa.pub| ssh user@remotebox cat >> ~/.ssh/authorized_keys"`

Play audio remotely:
`emph_it "       cat /dev/dsp | ssh user@remotebox cat > /dev/dsp"`

"'


alias tartips='
echo -e "`emph_it "  -c"`    : create a tar file
`emph_it "  -f"`    : specify the filename
`emph_it "  -t"`    : table of contents
`emph_it "  -x"`    : extract the contents of the tar file
`emph_it "  -v"`    : verbose output
`emph_it "  -z"`    : use zip/gzip as compression algorithm

`emph_it "tar -cvzf archive.tgz my_folder"` : archive folder
`emph_it "tar -tzf  archive.tgz"`           : see table of contents
`emph_it "tar -xvzf archive.tgz"`           : extract the contents into the directory it is invoked from
"'

alias xargstips='
echo -e "
`emph_it "find . -type f | xargs wc -l"` : same as passing all the files to wc
"'





