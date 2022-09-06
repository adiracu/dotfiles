#!/bin/zsh

source $HOME/.dotfiles/bin-internal/antigen.zsh

# antige bundle [<url> [<loc>]]
#	 		- Load the plugin found at <url>, and location <loc>
# e.g. antigen bundle ..oh-my.zsh.git plugins/ant
#
# antigen bundle <plugin-name>
#			- Same as above, but defaulst <url> to oh my zsh
#        - Tells antigen to install (if necessary) and load the given plugin
#
# antigen update
# 		   - To update all plugins
# antigen revert
# 			- Revert the plugins to how they were before the last 'antigen update'
# antigen snapshot
#			- create a snapshot of all the clones that are currently active
# antigen selfupdate
#			- update antigen itself
#
# antigen list
# 			- list installed plugins
# antigen theme
#			- switch the prompt theme to some used from the default repo url
# 			- basically lookes in the /themes part of the oh-my-zsh repo
# 			- can have the same <url> <loc> as bundle
#
# antigen apply
#			- start to actually add the plugins
#


# Load the oh-my-zsh's library.
antigen use oh-my-zsh
unsetopt inc_append_history
unsetopt share_history

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git

# Completion for the pip command
antigen bundle pip

# type any previous command and press up down
antigen bundle history-substring-search


# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme robbyrussell

# more completions
antigen bundle zsh-users/zsh-completions

# Tell antigen that you're done.
antigen apply

# Source all .zsh files in ~/.dotfiles/source
# Add binaries to the path
PATH=~/.dotfiles/bin:$PATH
export PATH

function src_zsh() {
  source ~/.dotfiles/bin-internal/source_files --extension zsh
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src_zsh
}

src_zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

