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
  { 'catppuccin/nvim', as = 'catppuccin' },
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

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = false,
    term_colors = true,
    integrations = {
        treesitter = true,
        lsp_trouble = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
        nvimtree = {
            enabled = true,
            show_root = false,
        },
        bufferline = true,
        markdown = true,
        lightspeed = true,
        ts_rainbow = true,
        notify = true,
    }
})

vim.cmd[[colorscheme catppuccin]]
