Inspired/Copied from https://raw.github.com/cowboy/dotfiles/

# Installation


`curl --silent https://raw.githubusercontent.com/rackenstein/dotfiles/master/bin/dotfiles | bash`

# Refresher

running ~/.dotfiles/bin/dotfiles has the prerequisite of:

* having `git` installed

The script will do:

1. This repo is cloned or updated into `~/.dotfiles` the directory
2. Files in `bin` are added to the PATH
3. `bin-internal/detect_labels` is ran to detect the valid labels according to `conf/label_detection_rules`
6. Files/dotfolders in `link` are linked into `~/`:
* the (.bashrc | .zshrc) files present here will:

    * source files ending in (*.sh | *.zsh) in `source` in alphanumeric order.
    * source files ending in (*.sh | *.zsh) in `source/valid_label` (see Labels below)
7. Optionally, call `install_packages_for_dotfile_labels` if you want



Notes: 

* Files overwritten by `copy` and `link` are saved into the `backups` directory
* Files with the exact filename found in `conf/dotfiles_ignore` will be skipped from all steps
* Files in `caches` are cached files.
* Files in `conf` just sit there. If a config file doesn't need to go to `~/`, put it there.
* Files in `bin` are executable shell scripts
* There were also `init` & `copy` folders that I've deleted

# Labels

In order to handle multiple os variations and work environments (work, home), labels are used. For example, a label can be an OS (`osx`, `arch`) or a work environment (`work`, `server`).

In order to use labels, 3 files are used:

* `conf/labels_detected` containing the labels detected for this computer
* `conf/label_detection_rules` contains the detection rules for label
* `bin/detect_labels` is run each time `dotfiles` is called, reading the detection rules and setting `conf/labels_detected`

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

A dotfolder is a folder that start with a `.`. When being passed a dotfolder, the `dotfiles` script will try and merge the contents of the dotfolder with the actual contents already present in $HOME. For example, assume that `~/.dotfiles/link/.dotfolderA` is being passed to the `link` function, and that there already exists a `~/.dotfolderA`. Normally, it would just do this:


 	 in ~                  in ~/.dotfiles/link/        would result in $HOME

    .dotfolderA            .dotfolderA'                 .dotfolderA -> ~/.dotfiles/link/.dotfolderA'
    ├── fileA1              ├── fileA1'
    ├── fileA2              ├── fileA3'
    └── folderB             └── folderB'        =>
        ├── fileB1              ├── fileB2'
        └── fileB2              └── folderC'
                                     └─ fileC1'

Doing this, the original files `$HOME/.dotfolderA/fileA2` and `$HOME/.dotfolderB/fileB1` are lost

As opposed to doing the entire directory passed, `dotfiles` will traverse it and try to merge them:


 	 in ~                  in ~/.dotfiles/link/        would result in $HOME

    .dotfolderA            .dotfolderA'                 .dotfolderA
    ├── fileA1              ├── fileA1'                   ├── fileA1 -> fileA1'
    ├── fileA2              ├── fileA3'                   ├── fileA2
    └── folderB             └── folderB'        =>        ├── fileA3 -> fileA3'
        ├── fileB1              ├── fileB2'               └── folderB
        └── fileB2              └── folderC'                   ├── fileB1
                                     └─ fileC1'                ├── fileB2 -> fileB2'
                                                               └── folderC -> folderC'
                                                                                   └─ fileC1'



# Install Packages - has to be called manually

The script `bin/install_packages_for_dotfile_labels` will check if predefined commands exists, and if not, it will try to install it using the appropriate package manager. It uses:

	1. the package manager specified in `conf/detected_label/package_manager`
	2. the rules specified in `conf/detected_label/packages` specified in the form:
	                         `cmd_to_test:package_to_install_if_cmd_missing`
	3. if the package manager does not exists, it will try to install it (only for `brew` on osx atm)

