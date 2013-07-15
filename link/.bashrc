# Add binaries to the path
PATH=~/.dotfiles/bin:$PATH
export PATH

# Source all files in ~/.dotfiles/source/
function src() {
   # echo "Sourcing"
  local file
  if [[ "$1" ]]; then
    source "$HOME/.dotfiles/source/$1.sh"
  else
  	 # Source all the files in source
    for file in `find ~/.dotfiles/source -maxdepth 1 -type f`; do
      source "$file"
    done

    # Now source all the files in each label
   local OLD_IFS="$IFS"
   IFS=$'\n'

    for file in `label_dotfiles ~/.dotfiles/source` ; do
      if test -f "${file}"; then
    	 source $file
      fi
    done

    IFS="$OLD_IFS"
  fi
}


# Run dotfiles script, then source.
function dotfiles() {
  ~/.dotfiles/bin/dotfiles "$@" && src
}

src
