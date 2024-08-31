# Neovim config
File structure:
```
.
├── init.lua                              ├── lazy-lock.json
├── lua
│   ├── base                              │   │   ├── init.lua
│   │   ├── plugins
│   │   │   ├── cmp.lua
│   │   │   └── lsp.lua
│   │   └── settings.lua
│   └── plugins.lua                       └── README.md

```

Package manager: Lazy.nvim

Neovim plugins:
* Treesitter
* Nvim-cmp
* Lualine
* Neovim lsp
* Nvim-autopair
* Luasnip
* Mason

Language servers:
* clangd for c/cpp
* Lua_ls for lua
