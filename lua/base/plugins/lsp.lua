local lspconfig = require('lspconfig')
local mason = require('mason-lspconfig');

require('mason').setup()

mason.setup({
    ensure_installed = { "lua_ls" },
})

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

lspconfig.clangd.setup{
    on_attach = on_attach,
}

lspconfig.lua_ls.setup{
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = {'vim'},
            },
        },
    },
}
