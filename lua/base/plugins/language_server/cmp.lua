local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  window = {
    completion = {
      border = 'rounded',
    },
    documentation = {
      border = 'rounded',
    },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        cmp.scroll_docs(4)
      else
        fallback()
      end
    end, { 'i', 'c' }),
    ['<Up>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
        cmp.scroll_docs(-4)
      else
        fallback()
      end
    end, { 'i', 'c' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },
  experimental = {
    ghost_text = true,
  },
})

local colors = require('kanagawa.colors').setup()

vim.api.nvim_set_hl(0, 'Pmenu', { bg = colors.sumiInk1, fg = colors.fujiWhite })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = colors.waveBlue2, fg = colors.fujiWhite, bold = true })
vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = colors.sumiInk0 })
vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = colors.crystalBlue })

vim.api.nvim_set_hl(0, 'CmpBorder', { fg = colors.sumiInk4, bg = colors.sumiInk1 })
