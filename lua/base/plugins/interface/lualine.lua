local function get_time()
  return ' ' .. os.date("%H:%M")
end

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = "gruvbox-material",
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        diagnostics_color = {
          error = { fg = '#dc322f' },
          warn = { fg = '#b58900' },
          info = { fg = '#268bd2' },
          hint = { fg = '#2aa198' },
        },
      },
    },
    lualine_x = {},
    lualine_y = { 'location' },
    lualine_z = { get_time },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { 'nvim-tree', 'trouble' },
}

vim.cmd([[autocmd! CursorHold * lua require('lualine').refresh()]])

vim.cmd([[
  augroup cmdheight
    autocmd!
    autocmd CmdlineEnter * setlocal cmdheight=0
    autocmd CmdlineLeave * setlocal cmdheight=0
  augroup END
]])
