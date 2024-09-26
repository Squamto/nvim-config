vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "When text is yanked, highlight the selection",
  group = vim.api.nvim_create_augroup('highlight-yqnk', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Coding Style for Kernel",
  group = vim.api.nvim_create_augroup('project-configs', { clear = false }),
  pattern = { "*kernel*/*.c", "*kernel*/*.h" },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 8
    vim.bo.softtabstop = 8
    vim.bo.tabstop = 8
  end,
})
