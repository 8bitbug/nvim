vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require("nvim-tree").setup({
    sort = {sorter = "case_sensitive"},
    view = {width = 30},
    renderer = {group_empty = true},
    filters = {dotfiles = true}
})

vim.cmd [[
  highlight NvimTreeNormal guibg=NONE
  highlight NvimTreeNormalNC guibg=NONE
  highlight NvimTreeEndOfBuffer guibg=NONE
  highlight NvimTreeFolderIcon guifg=#719e07
  highlight NvimTreeFolderName guifg=#719e07
  highlight NvimTreeOpenedFolderName guifg=#719e07
  highlight NvimTreeEmptyFolderName guifg=#719e07
  highlight NvimTreeFileIcon guifg=#268bd2
  highlight NvimTreeExecFile guifg=#859900
  highlight NvimTreeSpecialFile guifg=#cb4b16
  highlight NvimTreeSymlink guifg=#2aa198
]]
