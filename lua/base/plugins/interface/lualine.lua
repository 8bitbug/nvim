local function get_time()
  return ' ' .. os.date("%H:%M")
end

require('lualine').setup {
  options = {
    globalstatus = true,
    theme = "auto",
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(str)
          local mode_map = {
            ['NORMAL'] = ' NORMAL',
            ['INSERT'] = ' INSERT',
            ['VISUAL'] = '󰒅 VISUAL',
            ['V-LINE'] = '󰕷 V-LINE',
            ['V-BLOCK'] = '󰝤 V-BLOCK',
            ['REPLACE'] = '󰑌 REPLACE',
            ['COMMAND'] = ' COMMAND',
            ['TERMINAL'] = ' TERMINAL',
          }
          return mode_map[str] or str
        end,
      }
    },
    lualine_b = { 'branch', 'diff' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { {
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
      {
        'filename',
        path = 0,
        symbols = {
          modified = '●',
          readonly = '●',
          unnamed = '[No Name]',
        },
        fmt = function(str)
          local icon = require('nvim-web-devicons').get_icon(vim.fn.expand('%:t'), vim.fn.expand('%:e'),
            { default = true })
          return icon .. ' ' .. str
        end,
      }
    },
    lualine_z = { get_time },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
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
