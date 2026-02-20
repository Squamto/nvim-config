return {
  {
    'mikavilpas/yazi.nvim',
    version = '*',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      { '<leader>f', "<cmd>Yazi<cr>", desc = 'Open Yazi at current [f]ile' },
      { '<leader>cw', "<cmd>Yazi cwd<cr>", desc = 'Open Yazi at [C]urrent [W]orking Directory' },
      { '<leader>yr', "<cmd>Yazi toggle<cr>", desc = '[Y]azi [R]esume Session' },
    },
    opts = {
      open_for_directories = true,
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  }
}
