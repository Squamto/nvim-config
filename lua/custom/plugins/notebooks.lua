if false then
  return {}
else
  return {
    {
      "ajbucci/ipynb.nvim",
      opts = {},
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {}
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "ipynb" },
      opts = {
        overrides = {
          filetype = {
            ipynb = {
              -- Optional: keep the cursor line rendered in the notebook facade.
              anti_conceal = { enabled = false },
            },
          },
        },
      },
    }
  }
end
