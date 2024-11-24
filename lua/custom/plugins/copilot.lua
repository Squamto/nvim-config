return {
  {
    'github/copilot.vim',
    cond = vim.fn.executable 'node' == 1,
    lazy = true,
    cmd = 'Copilot',
    -- disable by default
    config = function()
      vim.g['copilot#enable'] = 0
    end,
  },
}
