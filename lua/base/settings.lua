vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true

vim.cmd [[
augroup TerminalSettings
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber nospell
augroup END
]]

vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<leader>cl', ':ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<leader>cl', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.api.nvim_set_keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>xx', ':Trouble diagnostics toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xf', ':Trouble diagnostics focus<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>nm', ':NoiceDismiss<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lg', ':LazyGit<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>ti', ':TimerlyToggle<CR>', { noremap = true, silent = true })
