return {
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    opts = {
      signcolumn = false,
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = 'u' },
      },
    },
    config = function(_, opts)
      local gitsigns = require('gitsigns')
      gitsigns.setup(opts)
      vim.keymap.set('n', '<leader>gb', gitsigns.blame, { desc = "[G]it [B]lame" })
    end
  },
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gs', '<cmd>top Git<CR>', noremap = true, silent = true, desc = '[G]it [S]tatus' },
    },
  },
}
