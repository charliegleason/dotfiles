stow -t $HOME zsh
stow -t $HOME nvim
git clone https://github.com/chriskempson/base16-shell.git $HOME/.config/base16-shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
