return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        inline = {
          adapter = "ollama"
        },
        chat = {
          adapter = "ollama"
        }
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    }
  },
  {
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  }
}
