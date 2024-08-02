return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').add {
        '<leader>s', { name = '[S]earch' }
      }
    end,
  },
}
