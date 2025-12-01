vim.opt.relativenumber = true

vim.opt.mouse = 'a'

vim.opt.showmode = false

vim.opt.breakindent = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 300

vim.opt.timeoutlen = 300

vim.opt.hlsearch = true

vim.opt.splitright = true
-- vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = {
  tab = '-->',
  trail = '·',
  nbsp = '␣',
}

vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.filetype.add {
  extension = {
    frag = 'glsl',
    vert = 'glsl',
    comp = 'glsl',
  }
}

-- vim: ts=2 sts=2 sw=2 et
