Inspired/Copied from https://raw.github.com/cowboy/dotfiles/

= Installation


= Refresher

running ~/.dotfiles/bin/dotfiles will do:

1. Git is installed if necessary, via pacman. If there is no pacman, it fails.
2. This repo is cloned updated into `~/.dotfiles` the directory
3. Files in `init` are executed, in alphanumeric order
4. Files in `copy` are copied into `~/`
5. Files in `link` are linked into `~/`

Also, the current setup will :

1. source files in `source` whenever a new shell is opened, in alphanumeric order.
2. backup files that get overwritten by `link` and `copy` into the `backups` directory


Others:

1. files in `caches` are cached files.
2. files in `conf` just sit there. If a config file doesn't need to go to `~/`, put it there.
3. files in `bin` are executable shell scripts


Nota Bene:

You can also put os specific stuff inside each of the `init` etc. folder
OS detection rules are defined in `conf/os_detection_rules`
		: The format is: os_key: cmd_to_run : expected_string_to_contain
	: The subfolders need to have the name `os_key`
		: scripts inside these subfolders get executed after the normal ones do
		: these folders will be ignored initially as they do not start with a dot
	: the script `init/detect_os.sh` sets the `conf/os_detected` value
