local lspconfig = require('lspconfig')
local mason = require('mason-lspconfig')

require('mason').setup()
mason.setup({ ensure_installed = { "lua_ls" } })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.diagnostic.config({ float = { border = "rounded" } })

local on_attach = function(client, bufnr)
  if client.name == "clangd" then
    client.server_capabilities.documentFormattingProvider = true
  end

  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  buf_set_keymap('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
  buf_set_keymap('v', '<leader>ca', '<cmd><C-U>Lspsaga range_code_action<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Lspsaga peek_definition<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)

  if client.name == "clangd" then
    buf_set_keymap('n', '<leader>m', '<cmd>lua vim.cmd("Man " .. vim.fn.expand("<cword>"))<CR>', opts)
    buf_set_keymap('n', '<leader>cm', '<cmd>lua vim.cmd("CppMan " .. vim.fn.expand("<cword>"))<CR>', opts)
  end

  buf_set_keymap('n', '<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>', opts)

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ timeout_ms = 2000 }) end
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
            globals = { "vim" }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true)
          }
        }
      }
    })
  end,
})

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--compile-commands-dir=.",
    "--query-driver=/usr/bin/clang++",
    "--header-insertion=never",
    "--background-index",
    "--completion-style=detailed",
    "--clang-tidy",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".clangd", ".git"),
  single_file_support = true,
  on_attach = on_attach,
  capabilities = vim.tbl_extend('keep', capabilities or {}, {
    textDocument = {
      publishDiagnostics = {
        relatedInformation = true,
        tagSupport = {
          valueSet = { 1, 2 },
        },
        severity = {
          [1] = "error",
          [2] = "warning",
          [3] = "info",
          [4] = "hint",
        },
      },
    },
  }),
  commands = {
    ClangdSwitchSourceHeader = {
      function() vim.cmd("ClangdSwitchSourceHeader") end,
      description = "Switch between source/header in clangd"
    }
  }
}

lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
        features = "all",
      },
      diagnostics = {
        enable = true,
        disabled = {
          -- Disable specific diagnostics if needed
          -- "unresolved-proc-macro",
          -- "inactive-code",
        },
        experimental = {
          enable = true,
        },
      },
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--all-targets", "--all-features" },
      },
      format = {
        enableRangeFormatting = true,
        extraArgs = { "--edition", "2021" },
      },
      inlayHints = {
        enable = true,
        parameterHints = true,
        typeHints = true,
        chainingHints = true,
        maxLength = nil,
      },
      completion = {
        postfix = {
          enable = true,
        },
        autoself = {
          enable = true,
        },
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

local signs = {
  Error = "●",
  Warn  = "●",
  Hint  = "●",
  Info  = "●"
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
})
