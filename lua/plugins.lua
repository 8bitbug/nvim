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
  {
    'echasnovski/mini.files',
    version = false,
    config = function()
      require('mini.files').setup()
    end
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end
  },
  {
    "cbochs/portal.nvim",
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon"
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup({})
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require('lspsaga').setup({
        lightbulb = {
          enable = false,
          sign = false,
          virtual_text = false,
          debounce = 0,
          sign_priority = 0,
        },
      })
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
    "goolord/alpha-nvim",
    event = "VimEnter",
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.zenbones_darken_comments = 45
      vim.cmd.colorscheme('zenbones')
    end
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
