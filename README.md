# Architecture 
```text
~/appdata/local/nvim/
├── init.lua
├── lazy-lock.json
└── lua
    ├── core
    │   ├── keymaps.lua
    │   ├── options.lua
    │   └── theme.lua
    └── plugins
        ├── neotree.lua
        ├── treesitter.lua
        ├── plugin.lua
        └── configs.lua
```
# Plug-ins 
This config uses [lazy.vim](https://github.com/folke/lazy.nvim) as a package manager and builds on [LazyVim](https://www.lazyvim.org/) and [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
## Quality of Life
- [autopairs](https://github.com/windwp/nvim-autopairs): [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Fautopairs.lua).
- [blink](https://github.com/Saghen/blink.nvim): Collection of small quality of life plug-ins. Used for [autocompletion](https://github.com/saghen/blink.cmp). [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Fblink.lua).
  [neotree](https://github.com/nvim-neo-tree/neo-tree.nvim): File explorer. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Fneo-tree.lua).
- mini: Collection of small quality of life plug-ins. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Fmini.lua).
- [telescope](https://github.com/nvim-telescope/telescope.nvim): Neovim fuzzy finder for lists. Extensible to many types of lists from files, to lists of avaliable plug-ins. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Ftelescope.lua).
- [todo-comments](https://github.com/folke/todo-comments.nvim): Highlight TODO/FIX/etc comments and make them searchable with telescope. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Ftodo-comments.lua).
- [which-key](https://github.com/folke/which-key.nvim): Preview Neovim keybinds while typing. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Fwhich-key.lua).
## User Interface
- [lualine](https://github.com/nvim-lualine/lualine.nvim): Customizable statusline. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Flualine.lua).
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim): Display git information in buffers. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Fgitsigns.lua).
## Language Support
- [treesitter](https://github.com/nvim-treesitter/nvim-treesitter/tree/main): Neovim implemention of the [tree-sitter parser](https://en.m.wikipedia.org/wiki/Tree-sitter_%28parser_generator%29). [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Ftreesitter.lua).
- [conform](https://github.com/stevearc/conform.nvim): Customizable formatter. [config file](https://github.com/Barca545/kickstart.nvim/blob/master/lua%2Fplugins%2Fconform.lua).
# Personal Keymaps
| Action | Personal Keymap | Nvim Default |
| ------ | --------------- | ------------ |
| Undo   | CTRL+Z          | u            |
| Save   | CTRL+S          | :w           |
| Copy   |                 | y            |
| Paste  |                 | p            |

