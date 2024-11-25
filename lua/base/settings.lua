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

vim.api.nvim_set_keymap('n', '<leader>cl', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<leader>cl', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ff', "<cmd>FzfLua files <CR>")
vim.keymap.set('n', '<leader>fg', "<cmd>FzfLua live_grep<CR>")
vim.keymap.set('n', '<leader>fb', "<cmd>FzfLua buffers<CR>")
vim.keymap.set('n', '<leader>fh', "<cmd>FzfLua helptags<CR>")

vim.keymap.set('n', '<leader>tt', MiniFiles.open, {})
vim.keymap.set('n', '<leader>tf', MiniFiles.close, {})

vim.api.nvim_set_keymap('n', '<leader>xx', ':Trouble diagnostics toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xf', ':Trouble diagnostics focus<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>nm', ':NoiceDismiss<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lg', ':LazyGit<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
