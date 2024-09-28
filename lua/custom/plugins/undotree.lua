return {
  {
    'mbbill/undotree',
    keys = '<leader>u',
    config = function()
      vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>', { silent = true, desc = 'Toggle UndoTree' })
    end
  }
}
