local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = {
                "   ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
                "   ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
                "   ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
                "   ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
                "   ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
                "   ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "  New file",
                                 ":ene <BAR> startinsert <CR>"),
                dashboard.button("f", "  Find file",
                                 ":Telescope find_files <CR>"),
                dashboard.button("r", "  Recent files",
                                 ":Telescope oldfiles <CR>"),
                dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
                dashboard.button("q", "  Quit NVIM", ":qa<CR>")
            }
            local function footer()
                local randomNumber = math.random(1, 10)
                if randomNumber == 1 then
                    return
                        "Programs must be written for people to read, and only incidentally for machines to execute."
                elseif randomNumber == 2 then
                    return
                        "The best error message is the one that never shows up."
                elseif randomNumber == 3 then
                    return
                        "Any fool can write code that a computer can understand. Good programmers write code that humans can understand."
                elseif randomNumber == 4 then
                    return "First, solve the problem. Then, write the code."
                elseif randomNumber == 5 then
                    return
                        "Code is like humor. When you have to explain it, it’s bad."
                elseif randomNumber == 6 then
                    return "Simplicity is the soul of efficiency."
                elseif randomNumber == 7 then
                    return "Make it work, make it right, make it fast."
                elseif randomNumber == 8 then
                    return
                        "Walking on water and developing software from a specification are easy if both are frozen."
                elseif randomNumber == 9 then
                    return
                        "Programming isn't about what you know; it's about what you can figure out."
                elseif randomNumber == 10 then
                    return "Deleted code is debugged code."
                else
                    return "Impossible..."
                end
            end

            dashboard.section.footer.val = footer()

            dashboard.config.layout = {
                {
                    type = "padding",
                    val = vim.fn.max {
                        2, vim.fn.floor(vim.fn.winheight(0) * 0.2)
                    }
                }, dashboard.section.header, {type = "padding", val = 5},
                dashboard.section.buttons, {type = "padding", val = 3},
                dashboard.section.footer
            }

            vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])

            alpha.setup(dashboard.config)
        end
    }, {
        'craftzdog/solarized-osaka.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require("solarized-osaka").setup({styles = {floats = "transparent"}})
            vim.cmd [[colorscheme solarized-osaka]]
        end
    }, {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {'nvim-lua/plenary.nvim'}
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons"}
    }, {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function() require('nvim-autopairs').setup({}) end
    }, {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"nvim-tree/nvim-tree.lua"}, {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    }, {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path", "hrsh7th/cmp-cmdline", "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip", "onsails/lspkind-nvim",
            "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim"
        }
    }
})
