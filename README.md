Inspired/Copied from https://raw.github.com/cowboy/dotfiles/

= Installation


= Refresher

running ~/.dotfiles/bin/dotfiles will do:

1. Git is installed if necessary, via pacman. If there is no pacman, it fails.
2. This repo is cloned or updated into `~/.dotfiles` the directory
3. Files in `bin` are added to the PATH
4. Files in `init` are executed, in alphanumeric order
5. Files in `copy` are copied into `~/`
6. Files in `link` are linked into `~/`

N.B. Files overwritten by `copy` and `link` are saved into the `backups` directory


Also, the current setup (.bashrc) will :

* source files in `source` whenever a new shell is opened, in alphanumeric order.


Others:

1. Files in `caches` are cached files.
2. Files in `conf` just sit there. If a config file doesn't need to go to `~/`, put it there.
3. Files in `bin` are executable shell scripts

= Labels

In order to handle multiple os variations and work environments (work, home), labels are used. For example, a label can be an OS (`osx`, `arch`) or a work environment (`work`, `server`).

In order to use labels, 3 files are used:

* `conf/labels_detected` containing the labels detected for this computer
* `conf/label_detection_rules` contains the detection rules for label
* `init/detect_labels.sh` is run each time `dotfiles` is called, reading the detection rules and setting `conf/labels_detected`

Detection rules have the following format:
	`label name: command to run : expected string to contain`
For example, in order to detect if the current computer is running OS X, it's is sufficient to check if `uname` contains the word `Darwin`. So the rules is:
 	`osx:uname:Darwin`

Each of the `init`, `copy` and `link` folders can contain label specific files, under a directory named with the appropriate `label name`.

To be more precise, the `dotfiles` script passes to de `init`, `copy` and `link` functions:
	1. all files found in the respective folder(e.g. /init) at depth 1, regardles of their  name
	2. all dot folders found in the respective folder at depth 1; their name has to start with "."
	3. all the files and folders found in the respective label folders
