return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()

      require('which-key').register( {
        s = { name = '[S]earch' }
      }, {prefix = '<leader>'})
    end,
  },
}
