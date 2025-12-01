return {
  {
    'nvim-mini/mini.nvim',
    branch = 'main',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings
      --
      -- Examples:
      -- - saiw( -> surrounds the word under the cursor with ()
      -- - sd( -> deletes the surrounding () from the word under the cursor
      -- - sr({ -> replaces the surrounding () with {}
      require('mini.surround').setup {}

      require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }

      require('mini.comment').setup {}

      require('mini.move').setup {}

      require('mini.pairs').setup {}

      require('mini.diff').setup {
        options = {
          algorithm = 'minimal',
        } }
      vim.keymap.set('n', '<leader>td', MiniDiff.toggle_overlay, { desc = '[T]oggle [D]iff View' })

      require('mini.files').setup {}
      vim.keymap.set('n', '<leader>f', MiniFiles.open, { desc = 'Open Mini [F]ile Explorer' })
    end
  }
}
