vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

require 'options'

require 'keymaps'

require 'commands'

require 'lazy-bootstrap'

require 'lazy-plugins'

vim.keymap.set('n', '<Esc>', '', { noremap = true, silent = true})

-- vim: ts=2 sts=2 sw=2 et
