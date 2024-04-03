return {
  {
    'github/copilot.vim',
    cond = vim.fn.executable 'node' == 1,
  }
}
