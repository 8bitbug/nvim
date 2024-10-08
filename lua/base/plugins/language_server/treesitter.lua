require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "c", "cpp" },
  sync_install = true,
  auto_install = true,
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true }
})
