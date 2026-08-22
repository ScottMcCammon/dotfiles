-- disable netrw (wimpy built-in file browser)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require('user.plugins')
require('nvim-tree').setup()

require('user.options')
require('user.keymaps')
