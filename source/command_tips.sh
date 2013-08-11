#!/bin/bash


function emph_it()   { echo -e "\033[0;36m$@\033[0m"; }


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

alias lstips='
echo -e "`emph_it "  -h"`              : print in human readable format
`emph_it "  -S"`              : sort by size
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

alias greptips='
echo -e "`emph_it "   --exclude-dir=\"pattern\" pattern folder_to_search_in"`   : if -R is specified, it exlucdes directories matching the pattern from the search
`emph_it "   -E pattern folder_to_search_in"`                      : --extended-regexp, use extended regular expression. See `emph_it egrep`
`emph_it "   -i pattern folder_to_search_in"`                      : --ignore-case
`emph_it "   -n pattern folder_to_search_in"`                      : --line-number, output line preceded by line number
`emph_it "   -r pattern folder_to_search_in"`                      : -R, --recursive, search recursively
`emph_it "   -v pattern folder_to_search_in" `                      : --invert--match, all the lines that do not match
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


