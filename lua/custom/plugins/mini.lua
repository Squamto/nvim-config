return {
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings
      --
      -- Examples:
      -- - saiw( -> surrounds the word under the cursor with ()
      -- - sd( -> deletes the surrounding () from the word under the cursor
      -- - sr({ -> replaces the surrounding () with {}
      require('mini.surround').setup()

      local statusline = require('mini.statusline')
      statusline.setup { use_icons = vim.g.have_nerd_font }
    end
  }
}
