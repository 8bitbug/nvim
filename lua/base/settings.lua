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

vim.api.nvim_set_keymap('n', '<leader>cl', '<cmd>terminal<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<cmd>e #<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>ff', "<cmd>FzfLua files <CR>")
vim.keymap.set('n', '<leader>fg', "<cmd>FzfLua live_grep<CR>")
vim.keymap.set('n', '<leader>fb', "<cmd>FzfLua buffers<CR>")
vim.keymap.set('n', '<leader>fh', "<cmd>FzfLua helptags<CR>")

vim.keymap.set('n', '<leader>tt', MiniFiles.open, {})
vim.keymap.set('n', '<leader>tf', MiniFiles.close, {})

vim.api.nvim_set_keymap('n', '<leader>xx', ':FzfLua lsp_workspace_diagnostics<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>nm', ':NoiceDismiss<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lg', ':LazyGit<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")

vim.keymap.set('n', '<leader>cs', "<cmd>FzfLua lsp_code_actions<CR>", { desc = "LSP Code Actions" })
vim.keymap.set('n', '<leader>ws', "<cmd>FzfLua lsp_workspace_symbols<CR>", { desc = "LSP Workspace Symbols" })
vim.keymap.set('n', '<leader>wd', "<cmd>FzfLua lsp_workspace_diagnostics<CR>", { desc = "LSP Workspace Diagnostics" })
