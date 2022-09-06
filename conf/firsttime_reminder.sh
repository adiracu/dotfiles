# This file is sourced at the end of a first-time dotfiles install.

shopt -s expand_aliases
source ~/.bashrc

# I'm forgetful. Just look at this repo's commits to see how many times I
# forgot to setup Git and GitHub.

cat <<EOF
Install useful commands/packages :  ~/.dotfiles/bin/install_packages_for_dotfile_labels

SSH password-less stuff : sshtips
EOF

# Change default shell used :
# 	brew install by default in /usr/local/bin so:
# 		1. add /usr/local/bin to /etc/shells
# 		2. chsh -s /usr/local/bin/zsh
# 		N.B. which zsh will still return the old one from /bin/zsh
# 		     but the brew one will be the one running
