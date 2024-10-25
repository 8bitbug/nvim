require('telescope').setup {
  defaults = {
    selection_caret = '  ',
    entry_prefix = '  ',
    file_ignore_patterns = { "node_modules" }
  }
}

require("telescope").load_extension("noice")

vim.cmd [[highlight CursorLine guibg=NONE guifg=#f2ebe3]]
