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
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("s", "  Settings", ":e $MYVIMRC <CR>"),
  dashboard.button("q", "  Quit NVIM", ":qa<CR>")
}

local function footer()
  local randomNumber = math.random(1, 10)
  if randomNumber == 1 then
    return "Programs must be written for people to read, and only incidentally for machines to execute."
  elseif randomNumber == 2 then
    return "The best error message is the one that never shows up."
  elseif randomNumber == 3 then
    return "Any fool can write code that a computer can understand. Good programmers write code that humans can understand."
  elseif randomNumber == 4 then
    return "First, solve the problem. Then, write the code."
  elseif randomNumber == 5 then
    return "Code is like humor. When you have to explain it, it’s bad."
  elseif randomNumber == 6 then
    return "Simplicity is the soul of efficiency."
  elseif randomNumber == 7 then
    return "Make it work, make it right, make it fast."
  elseif randomNumber == 8 then
    return "Walking on water and developing software from a specification are easy if both are frozen."
  elseif randomNumber == 9 then
    return "Programming isn't about what you know; it's about what you can figure out."
  elseif randomNumber == 10 then
    return "Deleted code is debugged code."
  else
    return "Impossible..."
  end
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
