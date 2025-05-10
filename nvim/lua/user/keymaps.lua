local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- keymaps for coding
keymap("n", "<leader>cl", "oconsole.log();<Left><Left>")
keymap("n", "<leader>nl", "o<ESC>")
keymap("n", "<leader>nla", "O<ESC>")
