# neovim symlink script
mkdir -p ~/.config

ln -sf "$(pwd)/nvim" ~/.config/nvim
echo "Symlink updated for nvim -> ~/.config/nvim