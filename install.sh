#!/bin/env bash

# symlink zsh and nvim configuration files
stow -t $HOME zsh
stow -t $HOME nvim

# Base16 Shell
git clone https://github.com/chriskempson/base16-shell.git \
    $HOME/.config/base16-shell

# Oh My ZSH and plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
zsh_plugin_dir=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
# autocompletion
git clone https://github.com/zsh-users/zsh-completions \
    $zsh_plugin_dir/plugins/zsh-completions
# syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    $zsh_plugin_dir/plugins/zsh-syntax-highlighting
# suggestions based on previous commands
git clone https://github.com/zsh-users/zsh-autosuggestions \
    $zsh_plugin_dir/plugins/zsh-autosuggestions
