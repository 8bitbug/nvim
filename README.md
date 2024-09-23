# Neovim config
This is my personal neovim config. 

For the icons and devicons to work you need a nerd font perferably an monospaced so the icons dont get cut off
in telescope, nvim-tree and etc

Package manager: Lazy.nvim

Neovim plugins:
* Treesitter
* Nvim-cmp
* Lualine
* Neovim lsp
* Nvim-autopair
* Luasnip
* Mason
* Telescope
* Tree
* Alpha

Theme: Solarized osaka

Language servers:
* clangd for c/c++
* Lua_ls for lua

Formatters:
* clang-format for c/c++

Linters:
* clang-tidy for c/c++

**Disclaimer**
You need to install clangd, clang-tidy and clang-format via your systems package manager or build from source
Make sure to include an compile_flags.txt  in your home directory for clang-tidy to work properly.
