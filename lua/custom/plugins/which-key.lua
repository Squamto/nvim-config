return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').register {
        -- ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch' },
      }
    end,
  },
}
