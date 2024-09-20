vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "When text is yanked, highlight the selection",
  group = vim.api.nvim_create_augroup('highlight-yqnk', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
