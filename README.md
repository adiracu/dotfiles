Inspired/Copied from https://raw.github.com/cowboy/dotfiles/

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
1. Folder `os_specific` contains subfolders with OS specific scripts
	: The OSs detection are defined in `os_specific/detection_rules`
		The format is: os_key: cmd_to_run : expected_string_to_contain
	: The subfolders in os_specific are named according to "os_key"
	: the script `os_specific/which_os.sh` returns the corresponding "os_key" to use
