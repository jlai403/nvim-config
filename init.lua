if vim.g.vscode then
  vim.keymap.set('n', 'gr', function()
    vim.call('VSCodeNotify', 'editor.action.referenceSearch.trigger')
  end)
end

if vim.g.vscode then
  vim.keymap.set('n', 'gt', function()
    vim.call('VSCodeNotify', 'editor.action.goToTypeDefinition')
  end)
end