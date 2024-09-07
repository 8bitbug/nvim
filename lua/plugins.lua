local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true

require("lazy").setup({
  { "rebelot/kanagawa.nvim" },
  {
      'dense-analysis/ale',               -- ALE for linting and formatting
      config = function()
          -- ALE Configuration for Clang-Tidy and Clang-Format
          vim.g.ale_linters = {
              cpp = {'clangtidy'},
              c = {'clangtidy'},
          }
          vim.g.ale_fixers = {
              cpp = {'clang-format'},
              c = {'clang-format'},
          }
          vim.g.ale_lint_on_save = 1      -- Enable linting on save
          vim.g.ale_fix_on_save = 1       -- Enable auto-format on save
      end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require('nvim-autopairs').setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {"nvim-tree/nvim-tree.lua"},
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind-nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    }
  },
})

vim.cmd("colorscheme kanagawa-dragon")
