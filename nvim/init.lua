vim.o.timeout = true
vim.o.timeoutlen = 500 

if vim.g.vscode then
  -- VSCode Neovim
  require "user.vscode_keymaps"
else
  -- Ordinary Neovim
end
