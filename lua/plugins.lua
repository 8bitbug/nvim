local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true

require("lazy").setup({
  { 'RaafatTurki/corn.nvim' },
  {
    '2kabhishek/octohub.nvim',
    cmd = {
      'OctoRepos',
      'OctoRepo',
      'OctoStats',
      'OctoActivityStats',
      'OctoContributionStats',
      'OctoRepoStats',
      'OctoProfile',
      'OctoRepoWeb',
    },
    keys = {
      '<leader>goa',
      '<leader>goc',
      '<leader>gof',
      '<leader>gog',
      '<leader>goh',
      '<leader>goi',
      '<leader>goo',
      '<leader>gop',
      '<leader>gor',
      '<leader>gos',
      '<leader>got',
      '<leader>gou',
      '<leader>gow',
    },
    dependencies = {
      '2kabhishek/utils.nvim',
      'nvim-telescope/telescope.nvim'
    },
    opts = {},
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = { { "nvim-treesitter/nvim-treesitter" } }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        use_diagnostics_signs = true,
        auto_close = true,
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
  },
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_transparent_background = true
      vim.cmd([[colorscheme gruvbox-material]])
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-tree/nvim-tree.lua" },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons"
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-calc",
      "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "onsails/lspkind-nvim",
      "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
      "f3fora/cmp-spell"
    }
  }
})
