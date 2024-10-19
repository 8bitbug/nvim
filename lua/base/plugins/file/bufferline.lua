require('bufferline').setup {
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
        text_align = "left"
      }
    },
  }
}

local fixBufferLineSeparator = function()
  vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", vim.api.nvim_get_hl_by_name('NvimTreeWinSeparator', true))
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = fixBufferLineSeparator,
})

fixBufferLineSeparator()
