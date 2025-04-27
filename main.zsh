#!/usr/bin/env zsh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BRED='\033[1;31m'
BGREEN='\033[1;32m'
BYELLOW='\033[1;33m'
BBLUE='\033[1;34m'
NC='\033[0m' # No Color

#################################
# install brew app
#################################

echo "${BGREEN}Installing Brew apps...${NC}"
brew bundle install

#################################
# update .zshrc
#################################
echo "${BGREEN}Updating .zshrc...${NC}"

if ! grep -q 'eval "$(starship init zsh)"' ~/.zshrc; then
  echo '
# Load starship prompt
eval "$(starship init zsh)"
' >> ~/.zshrc
  echo "${GREEN}Added starship prompt to ~/.zshrc ${NC}"
else
  echo "${YELLOW}Starship prompt already in ~/.zshrc ${NC}"
fi

if ! grep -q '# Load .dotfiles zsh configs' ~/.zshrc; then
  echo '
# Load .dotfiles zsh configs
for config in ~/.dotfiles/zsh/*.zsh; do
  source "$config"
done
' >> ~/.zshrc
  echo "${GREEN}Added .dotfile extensions to ~/.zshrc ${NC}"
else
  echo "${YELLOW}.dotfile extensions already in ~/.zshrc ${NC}"
fi

#################################
# update dotfiles via symlinks
#################################

# ssh
mkdir -p ~/.ssh

# Only add Includes if not already present
if ! grep -q "Include $(pwd)/ssh/\*.conf" ~/.ssh/config; then
  cp ~/.ssh/config ~/.ssh/config.bak_$(date '+%Y%m%d')
  echo "created backup of ~/.ssh/config -> ~/.ssh/config.bak_$(date '+%Y%m%d')"

  includes=$(cat <<EOF
Include $(pwd)/ssh/*.conf

EOF
)
  tmpfile=$(mktemp)
  echo "$includes" > "$tmpfile"
  [ -f ~/.ssh/config ] && cat ~/.ssh/config >> "$tmpfile"
  mv "$tmpfile" ~/.ssh/config
  echo "${GREEN}Added Include $(pwd)/ssh/*.conf -> ~/.ssh/config${NC}"
else
  echo "${YELLOW}Include already present in ~/.ssh/config ${NC}"
fi

mkdir -p ~/.config

# git symlink script
rm -rf ~/.config/git
ln -s "$(pwd)/git" ~/.config/git
echo "${GREEN}Symlink updated for $(pwd)/git -> ~/.config/git ${NC}"

# neovim symlink script
rm -rf ~/.config/nvim  # Remove existing symlink or directory
ln -s "$(pwd)/nvim" ~/.config/nvim
echo "${GREEN}Symlink updated for $(pwd)/nvim -> ~/.config/nvim ${NC}"

# tmux
ln -sf "$(pwd)/tmux/tmux.conf" "$HOME"/.tmux.conf;
echo "${GREEN}Symlink updated for tmux -> ~/.tmux.conf ${NC}"
tmux source-file ~/.tmux.conf

#################################
# OSX settings
#################################

# enable press and hold for special characters in VSCode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false