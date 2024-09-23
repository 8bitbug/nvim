local solarized_osaka = {
  normal = {
    a = { bg = '#859900', fg = '#002b36', gui = 'bold' },
    b = { bg = '#073642', fg = '#93a1a1' },
    c = { bg = '#002b36', fg = '#839496' }
  },
  insert = {
    a = { bg = '#268bd2', fg = '#002b36', gui = 'bold' },
  },
  visual = {
    a = { bg = '#d33682', fg = '#002b36', gui = 'bold' },
  },
  replace = {
    a = { bg = '#dc322f', fg = '#002b36', gui = 'bold' },
  },
  command = {
    a = { bg = '#b58900', fg = '#002b36', gui = 'bold' },
  },
  inactive = {
    a = { bg = '#002b36', fg = '#839496' },
    b = { bg = '#002b36', fg = '#586e75' },
    c = { bg = '#002b36', fg = '#839496' },
  },
}

local function get_time()
  return ' ' .. os.date("%H:%M")
end

require('lualine').setup {
  options = {
    theme = solarized_osaka,
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
        sections = { 'error', 'warn', 'info' },
        diagnostics_color = {
          error = { fg = '#dc322f' },
          warn  = { fg = '#b58900' },
          info  = { fg = '#268bd2' },
        },
        symbols = { error = ' ', warn = ' ', info = ' ' },
      }
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
}

vim.cmd([[
    autocmd! CursorHold * lua require('lualine').refresh()
]])
