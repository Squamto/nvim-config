require('lazy').setup {
  'tpope/vim-sleuth',
  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'warmer',
        transparent = true,
      }
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },

  { import = 'custom.plugins' },
}

-- vim: ts=2 sts=2 sw=2 et
