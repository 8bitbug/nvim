local lspconfig = require('lspconfig')
local mason = require('mason-lspconfig')

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
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", ".clangd", ".git"),
    single_file_support = true,
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.cpp", "*.h", "*.c"},
  callback = function()
    local current_buffer = vim.api.nvim_get_current_buf()
    local formatted_content = vim.fn.system("clang-format", vim.api.nvim_buf_get_lines(current_buffer, 0, -1, true))

    if vim.v.shell_error == 0 then
      vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, vim.split(formatted_content, "\n"))
    end
  end
})
