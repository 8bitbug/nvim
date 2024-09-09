local cmp = require('cmp')
local lspkind = require('lspkind')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

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
      require('luasnip').lsp_expand(args.body)
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
    { name = 'nvim_lsp', priority = 1000 },
    { name = 'luasnip', priority = 800 },
    { name = 'buffer', priority = 500 },
    { name = 'path', priority = 300 },
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

local highlights = {
  Pmenu = { bg = colors.sumiInk1, fg = colors.fujiWhite },
  PmenuSel = { bg = colors.waveBlue2, fg = colors.fujiWhite, bold = true },
  PmenuSbar = { bg = colors.sumiInk0 },
  PmenuThumb = { bg = colors.crystalBlue },
  CmpBorder = { fg = colors.sumiInk4, bg = colors.sumiInk1 },
  NormalFloat = { bg = colors.sumiInk1, fg = colors.fujiWhite },
  FloatBorder = { fg = colors.sumiInk4, bg = colors.sumiInk1 },
}

for group, opts in pairs(highlights) do
  vim.api.nvim_set_hl(0, group, opts)
end
