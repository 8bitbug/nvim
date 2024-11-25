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
  dashboard.button("e", "    New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "  󰈞  Find file", ":FzfLua files<CR>"),
  dashboard.button("r", "  󱋡  Recent files", ":FzfLua oldfiles<CR>"),
  dashboard.button("s", "    Settings", ":e ~/.config/nvim<CR>"),
  dashboard.button("q", "    Quit NVIM", ":qa<CR>")
}

local function footer()
  return ""
end

dashboard.section.footer.val = footer()

dashboard.config.layout = {
  { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
  dashboard.section.header,
  { type = "padding", val = 5 },
  dashboard.section.buttons,
  { type = "padding", val = 3 },
  dashboard.section.footer
}

vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

alpha.setup(dashboard.config)
