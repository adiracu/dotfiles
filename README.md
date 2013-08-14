Inspired/Copied from https://raw.github.com/cowboy/dotfiles/

# Installation


`curl --silent https://raw.github.com/rackenstein/dotfiles/master/bin/dotfiles | bash`

# Refresher

running ~/.dotfiles/bin/dotfiles will do:

1. Git is installed if necessary, via pacman. If there is no pacman, it fails.
2. This repo is cloned or updated into `~/.dotfiles` the directory
3. Files in `bin` are added to the PATH
4. Files/dotfolders in `init` are executed, in alphanumeric order
5. Files/dotfolders in `copy` are copied into `~/`
6. Files/dotfolders in `link` are linked into `~/`

, where dotfs means files

N.B. Files overwritten by `copy` and `link` are saved into the `backups` directory

N.B.2 Files with the exact filename found in `conf/dotfiles_ignore` will be skipped


Also, the current setup (.bashrc | .zshrc) will :

* source files ending in (*.sh | *.zsh) in `source` in alphanumeric order.
* source files ending in (*.sh | *.zsh) in `source/valid_label` (see Labels below)

whenever a new shell is opened.


Others:

1. Files in `caches` are cached files.
2. Files in `conf` just sit there. If a config file doesn't need to go to `~/`, put it there.
3. Files in `bin` are executable shell scripts

# Labels

In order to handle multiple os variations and work environments (work, home), labels are used. For example, a label can be an OS (`osx`, `arch`) or a work environment (`work`, `server`).

In order to use labels, 3 files are used:

* `conf/labels_detected` containing the labels detected for this computer
* `conf/label_detection_rules` contains the detection rules for label
* `init/detect_labels.sh` is run each time `dotfiles` is called, reading the detection rules and setting `conf/labels_detected`

Detection rules have the following format:
	`label name: command to run : expected string to contain`
For example, in order to detect if the current computer is running OS X, it's is sufficient to check if `uname` contains the word `Darwin`. So the rules is:
 	`osx:uname:Darwin`

Each of the `init`, `copy`, `conf` and `link` folders can contain label specific files, under a directory named with the appropriate `label name`.

To be more precise, the `dotfiles` script passes to de `init`, `copy` and `link` functions:

	1. all files found in the respective folder(e.g. /init) at depth 1, regardless of their name
	2. all dot folders found in the respective folder at depth 1; their name has to start with "."
	3. all the files and folders found in the respective label folders

# Dotfolders

A dotfolder is a folder that start with a `.`. When being passed a dotfolder, the `dotfiles` script will try and merge the contents of the dotfolder with the actual contents already present in $HOME.

e.g.
 	in $HOME             in ~/.dotfiles/..

```  .dotfolderA            .dotfolderA'

   ├── fileA1              ├── fileA1'

   ├── fileA2              ├── fileA3'```

   `└── folderB             └── folderB'`

    `    ├── fileB1              ├── fileB2'`

        `└── fileB2              └── folderC'`

         `                            └─ fileC1'`



# Automatically install packages
## should be called manually

The script `bin/install_all_for_labels` will check if predefined commands exists, and if not, it will try to install it using the appropriate package manager. It uses:

	1. the package manager specified in `conf/detected_label/package_manager`
	2. the rules specified in `conf/detected_label/packages` specified in the form `cmd_to_test:package_to_install_if_cmd_missing`
	3. if the package manager does not exists, it will try to install it (only for `brew` atm)

