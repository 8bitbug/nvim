vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort = { sorter = "case_sensitive" },
  view = { width = 30, adaptive_size = true },
  renderer = { group_empty = true, root_folder_label = false },
  filters = { dotfiles = true }
})

vim.cmd [[
  highlight NvimTreeNormal guibg=NONE
  highlight NvimTreeNormalNC guibg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE
  highlight NvimTreeWinSeparator guifg=#837771 guibg=NONE
  highlight NvimTreeCursorLine guibg=NONE guifg=#f2ebe3 ctermbg=NONE
  highlight NvimTreeGitDirty guibg=NONE ctermbg=NONE
  highlight NvimTreeGitNew guibg=NONE ctermbg=NONE
  highlight NvimTreeGitDeleted guibg=NONE ctermbg=NONE
  highlight NvimTreeGitIgnored guibg=NONE ctermbg=NONE
  highlight NvimTreeFolderIcon guifg=#f2ebe3 guibg=NONE
]]
