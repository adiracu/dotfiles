#!/bin/bash
# Add binaries to the path
PATH=~/.dotfiles/bin:$PATH
export PATH

function src_bash() {
  source ~/.dotfiles/bin-internal/source_files --extension sh
}

# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src_bash
}

src_bash
