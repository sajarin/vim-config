# Vim-Config

| Versions      | Description        |
| ------------- | ------------------ |
| minirc | a barebones, no plugin .vimrc |
| vimrc | a relatively small .vimrc with linting and quality of life plugins |
| nvimrc | my personal (now archived) .vimrc used in Neovim. |
| init.lua | my current config (neovim 0.8.2+ only) |

## What's inside?
### minirc

1. No plugins
2. Basic statusline with Git integration (shows branch info)
3. `:BufOnly` command, just like `:tabonly` but for buffers.
4. `ToggleCursors()` function, turns on cursorline and cursorcolumn.
5. Autocommand for opening images in vim, uses `xdg-open`, `open`, `start` for linux, macos, windows, respectively.

##### Keybindings
* These are all normal mode mappings
1. Abbreviations for fast fingers
2. `Ctrl J/K/L/H` for navigating to down, up, right, left split windows
3. `Ctrl up/down` and `leader ]/[` for adjusting split window size.
4. `gt, th, tn, tc` for navigating tabs (tabnext, tabprev, tabnew, tabclose)
5. `gb` for buffer jumping
6. `S` for search & replace all via `:%s//g`
7. `F4` for toggling spell check

### vimrc

* Everything in .minimalvimrc with plugins:
    * `vim-plug, vim-fugitive, vim-commentary, vim-textmanip, ALE, nerdtree, undotree, vim-airline, vim-airline-themes, vim-surround, vimwiki, ctrlp.vim, vim-startify, vim-devicons`

### nvimrc

* Everything in vimrc plus:
    * `coc.nvim, markdown-preview.nvim, venn.nvim, nvim-treesitter, nvim-web-devicons, bufferline.nvim, indent-blankline.nvim, plenary.nvim, popup.nvim, telescope.nvim, dashboard-nvim, emmet-vim, vim-quantum, tagbar, vim-nerdtree-syntax-highlight, vim-pencil, goyo.vim, vim-hexokinase, vim-highlightedyank, vim-signify, vim-flog, auto-pairs, vim-gutentags, vim-polyglot, vim-startuptime, vim-visual-star-search`
* `Toggle Conceals` function.
* Pattern match checkboxes and add conceals using unicode checkbox symbol in place.
* `:PrettifyJSON` command that uses python3 json.tool module.
* `:RemoveQFItem` command.
* `:RemoveAnswers` command for pattern matching anki answers.
* `:VimwikiToQF` command for recursively adding vimwiki links to QuickFixList.
* `statusline by kristijanhusak` in vimscript (needs nerdfont).
* Register + mappings for reversing an ordered list.
* Some lua plugins but mostly vimscript plugins.

### init.lua

##### Plugins:
* `lazy.nvim, Comment.nvim, LuaSnip, alpha-nvim, cmp-nvim-lsp, cmp_luasnip, colorful-winsep.nvim, fidget.nvim, gitsigns.nvim, harpoon, impatient.nvim, indent-blankline.nvim, kanagawa.nvim, lualine.nvim, markdown-preview.nvim, mason-lspconfig.nvim, mason.nvim, neodev.nvim, nvim-cmp, nvim-lspconfig, nvim-treesitter, nvim-treesitter-textobjects, nvim-web-devicons, plenary.nvim, project.nvim, telescope-fzf-native.nvim, telescope-project.nvim, telescope.nvim, undotree, vim-fugitive, vim-rhubarb, vim-sleuth, vim-visual-star-search, vim-speeddating, vimwiki`
* Mostly lazy loaded via keymap, command, filetype, or event activation.
* Majority lua plugins for nvim only, means they're faster.
* Sensible keymappings for plugins, follows semantic vim mappings (each char pressed describes of what it does. e.g. `<leader>sh = [S]earch [H]elp`).
* `Highlight on Yank` highlight group via autocommand, obsoletes 'vim-highlightedyank'.
* `Auto disable hlsearch` disables hl after search after cursor is moved.
* Sensible default LSP settings via `kickstart.nvim`.
