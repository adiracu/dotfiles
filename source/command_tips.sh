#!/bin/bash


function emph_it()   { echo -e "\033[0;36m$@\033[0m"; }


alias mantips='
echo -e "`emph_it man 1-9 page_name`              : gets the page from that section

`emph_it man -f word_to_search_for`      : search in the NAMES of man pages
                               : useful if you can'\''t remember the exact name of a command
                               : same as `emph_it whatis word_to_search_for`
                               : useful :  `emph_it whatis -w *partial_name`

`emph_it man -k word_to_search_for`      : search in the NAMES and VERY SHORT DESCRIPTION of man pages
                               : use if you want to search for a command that does something
                               : same as `emph_it apropos word_to_search_for`

`emph_it man -K word_to_search_for`      : search for a string in all pages
                               : brute force
                               : it asks if it should open after each page it finds

`emph_it man -s N -K word_to_search_for` : specify sections to narow search

`emph_it man -s N -K --regex REGEX`      : use a regex

`emph_it manjump word_to_jump_to page`   : same as opening the page and searching for word

`emph_it zcat`                           : cat for man pages
"'

alias lstips='
echo -e "`emph_it ls -h`              : print in human readable format
`emph_it ls -S`              : sort by size
"'

