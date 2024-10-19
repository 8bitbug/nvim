vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort = { sorter = "case_sensitive" },
  view = { width = 30 },
  renderer = { group_empty = true },
  filters = { dotfiles = true }
})

vim.cmd [[
  highlight NvimTreeNormal guibg=NONE
  highlight NvimTreeNormalNC guibg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE
  highlight NvimTreeWinSeparator guifg=#7c6f64 guibg=NONE
]]
