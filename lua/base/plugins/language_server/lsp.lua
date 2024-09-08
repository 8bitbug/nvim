local lspconfig = require('lspconfig')
local mason = require('mason-lspconfig')

require('mason').setup()

mason.setup({
    ensure_installed = { "lua_ls" },
})

local on_attach = function(client, bufnr)
    if client.name == "clangd" then
        client.server_capabilities.documentFormattingProvider = false
    end

    local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local buf_set_option = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() vim.lsp.buf.format() end,
        })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

mason.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {}
        })
    end,

    ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        })
    end,
})

-- Setup for system-installed LSP (clangd)
lspconfig.clangd.setup{
    cmd = { "clangd", "--header-insertion=never", "--background-index", "--completion-style=detailed" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", ".clangd", ".git"),
    single_file_support = true,
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        ClangdSwitchSourceHeader = {
            function() vim.cmd("ClangdSwitchSourceHeader") end,
            description = "Switch between source/header in clangd",
        },
    },
}
