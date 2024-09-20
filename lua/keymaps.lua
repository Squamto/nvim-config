vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostics' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Push diagnostics to QuickFixList' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to the window on the left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to the window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to the window above' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to the window on the right' })
