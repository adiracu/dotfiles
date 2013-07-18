#!/bin/bash

# Install all required packages for OSX, through brew
#

# --------------------------
# Global Variables

# Command to test if it exsits: Package to install for command
declare COMMAND_PACKAGES="git:git
htop:htop-osx
tree:tree
wget:wget
"

declare ASSUME_YES=
declare SHOULD_INSTALL_RESPONSE=

# Check for given arguments

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP

Usage: $(basename "$0") [--assume-yes]

--assume-yes : it won't ask for confirmation before each install

HELP
exit; fi

if [[ "$1" == "--asume-yes" ]]; then
	ASSUME_YES=1
fi

# --------------------------
# Function declarations
function e_question() { echo -e " \033[1;33m?\033[0m  $@"; }
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

COLOR_GREEN="\033[0;33m"
COLOR_BOLD_GREEN="\033[1;33m"
COLOR_OFF="\033[0m"
# Puts y,n or a in the variable SHOULD_INSTALL_RESPONSE
# $1 needs to be the command name
# $2 is the package name for the given command
function askForConfirmation() {

			if [[ "$ASSUME_YES" ]]; then
				SHOULD_INSTALL_RESPONSE='y'
				return
			fi

			SHOULD_INSTALL_RESPONSE=
			e_question "${COLOR_GREEN}$1${COLOR_OFF} command seems to be missing. Do you want to install it (via package ${COLOR_GREEN}$2${COLOR_OFF})? ."

			while [[ ! $SHOULD_INSTALL_RESPONSE =~ [y|a|n|e] ]]; do
	   		 echo -e "    ${COLOR_BOLD_GREEN}(y)${COLOR_OFF}es, yes to ${COLOR_BOLD_GREEN}(a)${COLOR_OFF}ll, ${COLOR_BOLD_GREEN}(n)${COLOR_OFF}o, ${COLOR_BOLD_GREEN}(e)${COLOR_OFF}xit  (5 second timeout, defaults to ${COLOR_BOLD_GREEN}no${COLOR_OFF})? ${COLOR_OFF}"
				# -r     : don't allow backslashes
				# -s     : don't echo key presses back to the terminal
				# -n 1   : only allow 1 character
				# -t 10  : timeout of 10 seconds
				SHOULD_INSTALL_RESPONSE="n"
				read -r -s -n 1 -t 5 SHOULD_INSTALL_RESPONSE
			done
}

function installPackageWithBrew()
{
	e_success "Installing package $1"
	echo brew install "$1"
}

function isCommandPresent()
{
	command -v $1 &>/dev/null
}

# -------------------------
# MAIN SCRIPT LOGIC

# Install brew if not installed
if ! isCommandPresent brew ; then
	e_arrow "Homebrew isn't installed. Trying to install it."
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
	exit 1
fi

if ! isCommandPresent brew ; then
	e_error "Homebrew still isn't installed, quitting"
	exit 1
fi

# Install all missing packages
while IFS=$':' read -r cmdToTest packageToInstall ; do

	if ! isCommandPresent "$cmdToTest"; then

		SHOULD_INSTALL_RESPONSE=d
		askForConfirmation "$cmdToTest" "$packageToInstall" </dev/tty

		echo $SHOULD_INSTALL_RESPONSE
		case $SHOULD_INSTALL_RESPONSE in
			y)
				installPackageWithBrew "$packageToInstall" ;;
			a)
				installPackageWithBrew "$packageToInstall"
				ASSUME_YES=1 ;;
			n)
				e_error "Skipping $packageToInstall" ;;
			e)
				e_error "Exiting, aborting entire install"
				exit 1 ;;
		esac

	fi

done <<< "$COMMAND_PACKAGES"
