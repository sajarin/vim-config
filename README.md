# Vim-Config

| Versions      | Description        |
| ------------- | ------------------ |
| minirc | a barebones, no plugin .vimrc |
| init.lua | my current config (neovim 0.9.5) |

## minirc

1. Basic statusline with Git integration (shows branch info)
2. `:BufOnly` command, just like `:tabonly` but for buffers.
3. `ToggleCursors()` function, turns on cursorline and cursorcolumn.
4. Autocommand for opening images in vim, uses `xdg-open`, `open`, `start` for linux, macos, windows, respectively.

## init.lua

### Keybindings

* These are all normal mode mappings
1. Abbreviations for fast fingers
2. `Ctrl J/K/L/H` for navigating to down, up, right, left split windows
3. `Ctrl up/down` and `Ctrl left/right` for adjusting split window size.
4. `gt, th, tn, tc` for navigating tabs (tabnext, tabprev, tabnew, tabclose)
5. `gb` for buffer jumping
6. `S` for search & replace all via `:%s//g`
7. `F4` for toggling spell check

