#!/usr/bin/env zsh

# Install Brew apps
echo 'Installing Brew apps...'
brew bundle install

# update zshrc
if ! grep -q 'for config in ~/.dotfiles/.zsh/*.zsh' ~/.zshrc; then
  echo '
# Load all custom extensions
for config in ~/.dotfiles/zsh/*.zsh; do
  source "$config"
done
' >> ~/.zshrc
  echo "Added custom extensions to ~/.zshrc"
else
  echo "Custom extensions already in ~/.zshrc"
fi

#################################
# update dotfiles via symlinks
#################################

# neovim symlink script
mkdir -p ~/.config
ln -sf "$(pwd)/nvim" ~/.config/nvim
echo "Symlink updated for nvim -> ~/.config/nvim"

# enable press and hold for special characters in VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false