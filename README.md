# Vim-Config

| Versions      | Description        |
| ------------- | ------------------ |
| [Minimal](https://github.com/Shaedil/vim-config/blob/master/.minimalvimrc) | No nonsense, no plugin config (rename `.minimalvimrc` to `.vimrc` to use it). |
| [Full Featured](https://github.com/Shaedil/vim-config/blob/master/.vimrc) | Minimal version but with plugins and plugin config.|


## Features

1. `:bufonly` command, just like `:tabonly` but for buffers.
2. `ToggleCursors()` function, turns on cusorline and cursorcolumn.
3. `VullScreen()` function, turns off annoying menu bar in GVim.
4. `View Images` autocmd, opens png, jpg, gif files from linux terminal using `xdg-open`.
5. `Statusline` that looks minimal but supports git integration (minimal version only).
6. `Keybindings` that are essential for navigating buffers, tabs, and splits.
7. `:Template` call any template of any filetype within the 'files' folder (full featured only).

### Calling the Functions

1. `ToggleCursors`: Press `F3`
2. `VullScreen`: Press `F11`
