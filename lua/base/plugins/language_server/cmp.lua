local cmp = require('cmp')
local lspkind = require('lspkind')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
  window = {
    completion = {
      border = 'rounded',
      winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      scrollbar = false,
    },
    documentation = {
      border = 'rounded',
      winhighlight = "NormalFloat:CmpDoc,FloatBorder:CmpDocBorder",
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
    { name = 'luasnip',  priority = 800 },
    { name = 'buffer',   priority = 500 },
    { name = 'path',     priority = 300 },
    { name = 'spell',    priority = 600 },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      before = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "",
          luasnip  = "",
          buffer   = "",
          path     = "",
          spell    = "",
        })[entry.source.name]
        return vim_item
      end,
    }),
  },
  experimental = {
    ghost_text = true,
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'cmdline' },
  },
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

vim.cmd([[highlight CmpPmenu guibg=NONE guifg=#C678DD]])
vim.cmd([[highlight CmpDoc guibg=NONE guifg=#ABB2BF]])
vim.cmd([[highlight Pmenu guibg=NONE guifg=#C678DD]])
vim.cmd([[highlight NormalFloat guibg=NONE]])
vim.cmd([[highlight FloatBorder guifg=#7c6f64 guibg=NONE]])
vim.cmd([[highlight CmpDocBorder guifg=#7c6f64 guibg=NONE]])
vim.cmd([[highlight PmenuSel guibg=#FFA500 guifg=#1d2021]])

vim.opt.spell = true
vim.opt.spelllang = { 'en_us' }

local ls = require('luasnip')

local doxygen_snippet = ls.parser.parse_snippet("docfn", "/**\n * $1\n *\n * $0\n */")

ls.snippets = {
  c = { doxygen_snippet },
  cpp = { doxygen_snippet },
}
