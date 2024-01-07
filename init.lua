--┌───────────────────────────────────────────────────────────────────┐
--│ Author:         Shaedil D.                                        │
--│ Website Link:   https://github.com/Shaedil/vim-config             │
--│ Description:    Edited version of nvim-lua/kickstart.nvim         │
--│ Last Modified:  1/7/24                                            │
--│ StartUpTimeAvg: 320 ms                                            │
--└───────────────────────────────────────────────────────────────────┘
-- lazy.nvim Bootstrap {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--- }}}
-- Plugins {{{
require('lazy').setup({
  {'folke/lazy.nvim',
    version = '*',
    lazy = true,
    colorscheme = { "kanagawa" },
  },
  {'williamboman/mason.nvim', cmd = "Mason"},
  {'neovim/nvim-lspconfig',
    event = { "BufRead", "BufNewFile", "InsertEnter" },
    dependencies = {
      {'williamboman/mason.nvim', config = true, cmd = {'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUninstall', 'MasonUninstallAll', 'MasonLog', 'MasonUpdate'}},
      {'williamboman/mason-lspconfig.nvim'},
      {'j-hui/fidget.nvim', event = 'BufReadPre'},
      {'folke/neodev.nvim', lazy = true},
    }
  },
  {'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'saadparwaiz1/cmp_luasnip', enabled = false},
      {'L3MON4D3/LuaSnip', dependencies = 'rafamadriz/friendly-snippets', enabled=false},
    }
  },
  {'tpope/vim-rhubarb',
    dependencies = {
      'tpope/vim-fugitive',
        cmd = {
          "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gsplit",
          "Gread", "Gwrite", "Ggrep", "Glgrep", "Gmove", "Gdelete",
          "Gremove", "Gbrowse",
        },
    },
    ft='fugitive'
  },
  {'tpope/vim-commentary'},
  {'vimwiki/vimwiki',
    init = function() -- replace 'config' with init'
      vim.g.vimwiki_list = {{
        path = '~/vimwiki',
      }}
      vim.g.vimwiki_folding = 'syntax'
    end,
  },
  {'github/copilot.vim', build = ":Copilot setup"},
  {'bronson/vim-visual-star-search', keys = {'*', '#', '<leader>*'}, lazy = true},
  {'ThePrimeagen/harpoon', event = "VeryLazy"},
  {'tpope/vim-speeddating', keys = {'C-A', 'C-X'}},
  {'nvim-tree/nvim-web-devicons', lazy = true},
  {'goolord/alpha-nvim', event = 'VimEnter'},
  {'iamcco/markdown-preview.nvim',
    ft = "markdown",
    build = 'cd app && npm install',
    init = function() vim.g.mkdp_filetypes = { "markdown" } end
  },
  {'nvim-zh/colorful-winsep.nvim', lazy = true, event = "WinEnter"},
  {'onsails/lspkind.nvim', lazy = true},
  {'norcalli/nvim-colorizer.lua', lazy = true, event = "BufReadPost"},
  {'folke/todo-comments.nvim',
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufRead", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {'rebelot/kanagawa.nvim', lazy = true, event = 'VeryLazy'},
  {'lukas-reineke/indent-blankline.nvim', main = "ibl"},
  {'nvim-lualine/lualine.nvim', event = "VeryLazy"},
  {'lewis6991/gitsigns.nvim', event = 'BufReadPre', dependencies = {'nvim-lua/plenary.nvim'}},
  {'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufRead',
    keys = {
      { "<c-space>" },
      { "<c-backspace>", mode = "x"}
    }
  },
  {'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
    dependencies = {
      {'ahmedkhalf/project.nvim', event = "VeryLazy"}
    },
  },
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'},
  {'nvim-telescope/telescope-ui-select.nvim'},
  {'debugloop/telescope-undo.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
})
-- }}}
-- Vim Settings {{{
-- See `:help vim.o`
vim.loader.enable()
vim.opt.showmode = false
vim.opt.shortmess = "icfxtoTOlFI"
vim.opt.mouse = 'a'
vim.opt.confirm = true
vim.opt.pumheight = 20
-- gui settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.title = true
vim.opt.laststatus = 3
vim.opt.fillchars:append({diff='╱'})
vim.opt.conceallevel = 2
-- vim.opt.signcolumn = 'yes'
vim.opt.signcolumn = 'auto'
vim.opt.guifont = "JetBrainsMono NFM:h10"
-- optimizations
vim.opt.breakindent = true
vim.opt.synmaxcol = 300
-- autocompletion + path + undo
vim.opt.path = '.,**'
vim.go.wildmode = 'longest:full'
vim.go.wildignore = "*.swip, *.bak, *.pyc, *.class, *.sln, *.Master, *.csproj, *.csproj.user, *.cache, *.dll, *.pdb, *.min.*, */.git/**/*, */.hg/**/*, */.svn/**/*, tags, *.tar.*"
vim.opt.undofile = true
-- Fold settings
vim.opt.foldmethod = 'marker'
-- vim.opt.foldnestmax = 10
-- vim.opt.foldlevelstart = 0
-- indentation
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.o.expandtab=true
-- }}}
-- Config {{{
-- Lualine {{{
local lualine = require('lualine')
local lualine_colors = {
  bg       = '#191919',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}
local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = {
      normal = { c = { fg = lualine_colors.fg, bg = lualine_colors.bg } },
      inactive = { c = { fg = lualine_colors.fg, bg = lualine_colors.bg } },
    },
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      { function()
          return '▊'
        end,
        color = { fg = lualine_colors.blue },
        padding = { right = 1 },
      },
      { 'mode',
        color = function()
          local mode_color = {
            n = lualine_colors.red,
            i = lualine_colors.green,
            v = lualine_colors.blue,
            [''] = lualine_colors.blue,
            V = lualine_colors.blue,
            c = lualine_colors.magenta,
            no = lualine_colors.red,
            s = lualine_colors.orange,
            S = lualine_colors.orange,
            [''] = lualine_colors.orange,
            ic = lualine_colors.yellow,
            R = lualine_colors.violet,
            Rv = lualine_colors.violet,
            cv = lualine_colors.red,
            ce = lualine_colors.red,
            r = lualine_colors.cyan,
            rm = lualine_colors.cyan,
            ['r?'] = lualine_colors.cyan,
            ['!'] = lualine_colors.red,
            t = lualine_colors.red,
          }
          return { fg = mode_color[vim.fn.mode()] }
        end,
        padding = { right = 1 },
      },
      { 'filesize',
        cond = conditions.buffer_not_empty,
      },
      { 'filetype',
        colored = true,
        icon_only = true,
      },
      { 'filename',
        cond = conditions.buffer_not_empty,
        color = { fg = lualine_colors.magenta, gui = 'bold' },
        symbols = {
          modified = '●',
          alternate_file = '#',
          directory =  '',
        }
      },
      { 'location'},
      { 'progress',
        color = { fg = lualine_colors.fg, gui = 'bold' },
      },
      { 'diagnostics',
        sources = { 'nvim_lsp' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          color_error = { fg = lualine_colors.red },
          color_warn = { fg = lualine_colors.yellow },
          color_info = { fg = lualine_colors.cyan },
        },
        sections = { 'error', 'warn', 'info' },
        cond = conditions.hide_in_width,
      },
      { function()
          return '%='
        end,
      },
      { function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = ' LSP:',
        color = { fg = lualine_colors.cyan, gui = 'bold' },
      },
    },
    lualine_x = {
      { 'o:encoding',
        fmt = string.upper,
        cond = conditions.hide_in_width,
        color = { fg = lualine_colors.green, gui = 'bold' },
      },
      { 'fileformat',
        fmt = string.upper,
        icons_enabled = false,
        color = { fg = lualine_colors.green, gui = 'bold' },
        cond = conditions.hide_in_width,
      },
      { 'branch',
        icon = '',
        color = { fg = lualine_colors.violet, gui = 'bold' },
      },
      { 'diff',
        symbols = { added = ' ', modified = '柳 ', removed = ' ' },
        diff_color = {
          added = { fg = lualine_colors.green },
          modified = { fg = lualine_colors.orange },
          removed = { fg = lualine_colors.red },
        },
        cond = conditions.hide_in_width,
      },
      { function()
          return '▊'
        end,
        color = { fg = lualine_colors.blue },
        padding = { left = 1 },
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'},
  },
  extensions = { 'quickfix', 'fugitive' },
}

lualine.setup(config)
-- }}}
-- Alpha.nvim {{{
require('alpha').setup(require('alpha.themes.dashboard').config)
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {
  [[                                              ___  ]],
  [[                                           ,o88888 ]],
  [[       NEOVIM                           ,o8888888' ]],
  [[                  ,:o:o:oooo.        ,8O88Pd8888"  ]],
  [[              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"    ]],
  [[            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"      ]],
  [[           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"        ]],
  [[          , ..:.::o:ooOoOO8O888O8O,COCOO"          ]],
  [[         , . ..:.::o:ooOoOOOO8OOOOCOCO"            ]],
  [[          . ..:.::o:ooOoOoOO8O8OCCCC"o             ]],
  [[             . ..:.::o:ooooOoCoCCC"o:o             ]],
  [[             . ..:.::o:o:,cooooCo"oo:o:            ]],
  [[          `   . . ..:.:cocoooo"'o:o:::'            ]],
  [[          .`   . ..::ccccoc"'o:o:o:::'             ]],
  [[         :.:.    ,c:cccc"':.:.:.:.:.'              ]],
  [[       ..:.:"'`::::c:"'..:.:.:.:.:.'               ]],
  [[     ...:.'.:.::::"'    . . . . .'                 ]],
  [[    .. . ....:."' `   .  . . ''                    ]],
  [[  . . . ...."'                    SATURN           ]],
  [[  .. . ."'                                         ]],
  [[ .                                                 ]],
}

dashboard.section.buttons.val = {
  dashboard.button("SPC f", " Find file", ":Telescope find_files <CR>"),
  dashboard.button("SPC e", " New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("SPC p", " Find project", ":Telescope projects <CR>"),
  dashboard.button("SPC r", " Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("SPC c", " Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("SPC q", " Quit Neovim", ":qa<CR>"),
}
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
-- dashboard.opts.opts.noautocmd = true
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    local stats = require("lazy").stats()
    stats.real_cputime = true
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    pcall(vim.cmd.AlphaRedraw)
  end,
})
vim.cmd([[autocmd User AlphaReady echo 'Alpha is ready']])
-- }}}
-- Vimwiki {{{
-- change vimwiki to markdown for markdown files 
vim.api.nvim_command("autocmd BufEnter,BufRead,BufNewFile *.md set filetype=markdown")
vim.api.nvim_command("autocmd BufNewFile,BufRead *.wiki setlocal nonu nornu nofoldenable")

vim.api.nvim_set_hl(0, "VimwikiHeader1", {fg="#98BB6C"}) -- spring green
vim.api.nvim_set_hl(0, "VimwikiHeader2", {fg="#FF5D62"}) -- peach red
vim.api.nvim_set_hl(0, "VimwikiHeader3", {fg="#FFA066"}) -- surimi orange
vim.api.nvim_set_hl(0, "VimwikiHeader4", {fg="#7FB4CA"}) -- crystal blue
vim.api.nvim_set_hl(0, "VimwikiHeader5", {fg="#957FB8"}) -- oni violet
vim.api.nvim_set_hl(0, "VimwikiHeader6", {fg="#D27E99"}) -- sakura pink
-- }}}
-- Indent-blankline  {{{
-- See `:help ibl`
require('ibl').setup {
  debounce = 100,
  indent = { char = "┊" },
  whitespace = {
    highlight = { "Whitespace", "NonText" },
  },
  scope = {
    char = "▎",
  },
  exclude = {
    filetypes = {
      "alpha", "dashboard", "TelescopeResults", "TelescopePrompt", "lazy",
      "vimwiki", "NvimTree", "lsp-installer", "checkhealth", "mason",
      "lazyterm", "toggleterm"
    },
    buftypes = {
      "_.*"
    },
  },
}
--- }}}
-- Gitsigns  {{{
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  current_line_blame_formatter = '<author>, <author_time:%m-%d-%Y> - <summary>',
  current_line_blame_formatter_opts = { relative_time = false },
}
--- }}}
-- Telescope  {{{
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    prompt_prefix = " ",
    selection_caret = " ",
    layout_config = {
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
      vertical = { mirror = false },
      horizontal = { mirror = false }
    },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    file_ignore_patterns = { "node_modules" },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '-u',
      '-u',
    },
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case"        -- or "ignore_case" or "respect_case"
      },
      undo = {
        use_delta = true,
        side_by_side = false,
      },
    },
  }
}
--- }}}
-- Telescope Extension  {{{
-- Enable Telescope extensions
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'harpoon')
pcall(require('telescope').load_extension, 'projects')
pcall(require('telescope').load_extension, 'undo')
pcall(require('telescope').load_extension, 'ui-select')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
-- }}}
-- Treesitter  {{{
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'vimdoc', 'vim', 'svelte', 'css', 'json', 'javascript', 'java', 'html', 'scss'
  },
  modules = {},
  sync_install = false,
  ignore_install = {},
  auto_install = false,
  highlight = { enable = true },
  indent = { enable = true, },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<C-space>',
      node_incremental = '<C-space>',
      scope_incremental = false,
      node_decremental = '<C-backspace>',
    },
  },
}
--}}}
-- Harpoon  {{{
require('harpoon').setup()
-- }}}
-- Colorscheme  {{{
require('kanagawa').setup({
  globalStatus = true,
  theme = "dark",
  colors = {
    theme = { all = { ui = { bg_gutter = "none" } } }
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },
      NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
      LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, }, -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = theme.ui.bg_p1 },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
      TelescopePreviewNormal = { bg = theme.ui.bg_dim },
      TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
    }
  end,
})
vim.cmd("colorscheme kanagawa")
-- }}}
-- LSP Signs  {{{
local signs = { Error = "✘ ", Warn = "⚠️ ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- }}}
-- Comment.nvim  {{{
-- require('Comment').setup()
-- }}}
-- Project.nvim  {{{
require('project_nvim').setup({silent_chdir = true, show_hidden = false})
-- }}}
-- Colorful-winsep.nvim  {{{
require('colorful-winsep').setup({
  no_exec_files = { "packer", "TelescopePrompt", "mason", "lazy", }
})
-- }}}
-- Nvim-web-devicons  {{{
require('nvim-web-devicons').setup({
 color_icons = true;
 default = true;
 strict = true;
})
-- }}}
-- Todo-comments.nvim  {{{
require'todo-comments'.setup({
  colors = {
    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
    info = { "DiagnosticInfo", "#2563EB" },
    hint = { "DiagnosticHint", "#10B981" },
    default = { "Identifier", "#7C3AED" },
    test = { "Identifier", "#FF00FF" }
  },
})
-- }}}
-- Colorizer {{{
require 'colorizer'.setup()
-- }}}
-- }}}
-- Keymappings {{{
-- See `:help vim.keymap.set()`
-- aliases vim.keymap.set() to respective vim functions
-- sets space as <leader> instead of actual leader key
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', { silent = true })
vim.api.nvim_set_keymap('v', '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap 
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Mappings for telescope
vim.api.nvim_set_keymap('n', '<leader>sf', '<cmd>lua require("telescope.builtin").find_files()<CR>', { desc = '[S]earch [F]iles' })
vim.api.nvim_set_keymap('n', '<leader>sh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', { desc = '[S]earch [H]elp' })
vim.api.nvim_set_keymap('n', '<leader>sk', '<cmd>lua require("telescope.builtin").keymaps()<CR>', { desc = '[S]earch [K]ey mappings' })
vim.api.nvim_set_keymap('n', '<leader>sw', '<cmd>lua require("telescope.builtin").grep_string()<CR>', { desc = '[S]earch current [W]ord' })
vim.api.nvim_set_keymap('n', '<leader>sg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', { desc = '[S]earch by [G]rep' })
vim.api.nvim_set_keymap('n', '<leader>sd', '<cmd>lua require("telescope.builtin").diagnostics()<CR>', { desc = '[S]earch [D]iagnostics' })
vim.api.nvim_set_keymap('n', '<leader>sm', '<cmd>lua require("telescope.builtin").marks()<CR>', { desc = '[S]earch [M]arks' })
vim.api.nvim_set_keymap('n', '<leader>sp', '<cmd>lua require("telescope").extensions.projects.projects()<CR>', { desc = '[S]earch [P]rojects' })
vim.api.nvim_set_keymap('n', '<leader>u',  '<cmd>lua require("telescope").extensions.undo.undo()<CR>', { desc = '[U]ndo tree toggle' })
-- git
vim.api.nvim_set_keymap('n', "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "[G]it [C]ommits" })
vim.api.nvim_set_keymap('n', "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "[G]it [S]tatus" })
-- Split window nav
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', { desc = 'Move cursor to window left of current' })
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', { desc = 'Move cursor to window below current' })
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', { desc = 'Move cursor to window above current' })
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', { desc = 'Move cursor to window right of current' })
-- Terminal nav
vim.api.nvim_set_keymap('t', '<C-W>h', '<C-\\><C-N><C-W>h', { desc = 'Move cursor from terminal to left window' })
vim.api.nvim_set_keymap('t', '<C-W>j', '<C-\\><C-N><C-W>j', { desc = 'Move cursor from terminal to window below' })
vim.api.nvim_set_keymap('t', '<C-W>k', '<C-\\><C-N><C-W>k', { desc = 'Move cursor from terminal to window above' })
vim.api.nvim_set_keymap('t', '<C-W>l', '<C-\\><C-N><C-W>l', { desc = 'Move cursor from terminal to right window' })
-- move line(s) in visual mode with auto indentation
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { silent = true })
-- Split window size
vim.api.nvim_set_keymap('n', '<C-up>', '<C-w>+', { desc = 'Vertically size [UP] the current window' })
vim.api.nvim_set_keymap('n', '<C-down>', '<C-w>-', { desc = 'Vertically size [DOWN] the current window' })
vim.api.nvim_set_keymap('n', '<C-right>', '<C-w>>', { desc = 'Horizontally increase size of current window' })
vim.api.nvim_set_keymap('n', '<C-left>', '<C-w><', { desc = 'Horizontally decrease size of current window' })
vim.api.nvim_set_keymap('n', '<C-=>', '<C-w>=', { desc = '[=]alize all windows in current tab' })
vim.api.nvim_set_keymap('n', '<C-_>', '<C-W>_', { desc = 'Maximize current window size in current tab' })
-- Tab nav gt is default 
vim.api.nvim_set_keymap('n', 'gt', '<cmd>tabnext<CR>', { desc = '[G]o [T]o next tab page' })
vim.api.nvim_set_keymap('n', 'th', '<cmd>tabprev<CR>', { desc = '[T]ab to previous tab page' })
vim.api.nvim_set_keymap('n', 'tn', '<cmd>tabnew<CR>', { desc = 'Make a [T]ab that is [N]ew' })
vim.api.nvim_set_keymap('n', 'tc', '<cmd>tabclose<CR>', { desc = 'Make current [T]ab [C]losed' })
-- Fugitive Conflict Resolution
-- based on: https://medium.com/prodopsio/solving-git-merge-conflicts-with-vim-c8a8617e3633
vim.api.nvim_set_keymap('n', '<leader>gd', '<cmd>Gvdiff<CR>', { desc = 'Start [G]it vertical [D]iff' })
vim.api.nvim_set_keymap('n', 'gdh', '<cmd>diffget //1<CR>', { desc = 'Accept change from left (HEAD) in [G]it [D]iff' })
vim.api.nvim_set_keymap('n', 'gdl', '<cmd>diffget //3<CR>', { desc = 'Accept change from right (master) in [G]it [D]iff' })
-- harpoon keybindings
vim.api.nvim_set_keymap('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file()<CR>', { desc = '[H]arpoon [A]dd file' })
vim.api.nvim_set_keymap('n', '<leader>hm', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = 'Open [H]arpoon [M]enu' })
vim.api.nvim_set_keymap('n', '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', { desc = '[H]arpoon file [1]' })
vim.api.nvim_set_keymap('n', '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>', { desc = '[H]arpoon file [2]' })
vim.api.nvim_set_keymap('n', '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>', { desc = '[H]arpoon file [3]' })
vim.api.nvim_set_keymap('n', '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true, desc = '[H]arpoon file [4]' })
vim.api.nvim_set_keymap('n', '<leader>h5', '<cmd>lua require("harpoon.ui").nav_file(5)<CR>', { noremap = true, silent = true, desc = '[H]arpoon file [5]' })
vim.api.nvim_set_keymap('n', '<leader>h6', '<cmd>lua require("harpoon.ui").nav_file(6)<CR>', { noremap = true, silent = true, desc = '[H]arpoon file [6]' })
vim.api.nvim_set_keymap('n', '<leader>h7', '<cmd>lua require("harpoon.ui").nav_file(7)<CR>', { noremap = true, silent = true, desc = '[H]arpoon file [7]' })
vim.api.nvim_set_keymap('n', '<leader>h8', '<cmd>lua require("harpoon.ui").nav_file(8)<CR>', { noremap = true, silent = true, desc = '[H]arpoon file [8]' })
vim.api.nvim_set_keymap('n', '<leader>h9', '<cmd>lua require("harpoon.ui").nav_file(9)<CR>', { noremap = true, silent = true, desc = '[H]arpoon file [9]' })
-- Replace all is aliased to S
vim.api.nvim_set_keymap('n', 'S', ':%s//g<Left><Left>', { desc = '[S]ubstitute and replace all in buffer' })
-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = '[D]iagnostic previous' })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = '[D]iagnostic next' })
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = '[D]iagnostic open float' })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { desc = '[D]iagnostic set loclist' })
-- }}}
-- Custom Functions, Commands & Autocommands {{{
-- A function that deletes all unmodified buffers except current buffer {{{
local function delete_unmodified_buffers_except_current()
  local current_buffer = vim.api.nvim_get_current_buf()
  local all_buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(all_buffers) do
    if buf ~= current_buffer and not vim.api.nvim_buf_get_option(buf, 'modified') then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end
vim.api.nvim_create_user_command('BufOnly', delete_unmodified_buffers_except_current, {})
-- }}}
-- Highlight on yank {{{
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({timeout = 700})
  end,
  group = highlight_group,
  pattern = '*',
})
-- }}}
-- Add checkboxes to *.wiki files {{{
local function setup_conceal()
  local conceal_id1 = pcall(vim.fn.match, vim.fn.bufnr(), 12)
  local conceal_id2 = pcall(vim.fn.match, vim.fn.bufnr(), 13)
  if not conceal_id1 then
    vim.api.nvim_command("call matchadd('Conceal', '\\[\\ \\]', 0, 12, {'conceal': '' })")
  end
  if not conceal_id2 then
    vim.api.nvim_command("call matchadd('Conceal', '\\[X\\]', 0, 13, {'conceal': '' })")
  end
  vim.api.nvim_command("hi def link todoCheckbox Todo")
  vim.api.nvim_set_hl(0, 'Conceal', {ctermbg = 'NONE', ctermfg = 'NONE', bg = 'NONE', fg = 'NONE'})
end
setup_conceal()
-- vim.api.nvim_command("hi Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")
-- }}}
-- Disable hlsearch automatically {{{
local ns = vim.api.nvim_create_namespace('toggle_hlsearch')
local function toggle_hlsearch(char)
  if vim.fn.mode() == 'n' then
    local keys = { '<CR>', 'n', 'N', '*', '#', '?', '/' }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end
vim.on_key(toggle_hlsearch, ns)
-- }}}
-- Cleaner folds {{{
vim.cmd([[
function! NeatFoldText()
    let line = substitute(getline(v:foldstart), '/\*\|\*/\|{{{\d\=\|--', '', 'g') "}}}
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '│ ' . printf("%10s", lines_count . ' lines') . ' │'
    let foldchar = ' '
    let foldtextstart = strpart('█' . repeat(foldchar, v:foldlevel) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()
]])
-- }}}
-- }}}
-- LSP settings {{{
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require('mason').setup()
local servers = {}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup()

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
-- Turn on lsp status information
require('fidget').setup({})

-- nvim-cmp setup
local cmp = require 'cmp'
local str = require 'cmp.utils.str'
local types = require 'cmp.types'
-- local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

-- require('luasnip.loaders.from_vscode').lazy_load()
-- luasnip.config.setup {}

cmp.setup {
  -- snippet = {
  --   expand = function(args)
  --     luasnip.lsp_expand(args.body)
  --   end
  -- },
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
    { name = 'buffer', keyword_length = 5, max_item_count = 5 },
  }),

  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    expandable_indicator = false,
    format = lspkind.cmp_format({
      symbol_map = {
        Text = "", Method = "", Function = "ƒ", Constructor = "", Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
        Module = "", Property = "󰜢", Unit = "", Value = "", Enum = "", Keyword = "", Snippet = "", Color = "", File = "",
        Reference = "", Folder = "", EnumMember = "", Constant = "", Struct = "", Event = "", Operator = "", TypeParameter = "<>",
      },
      mode = 'symbol_text',
      maxwidth = 52,
      ellipsis_char = '⋯',

      before = function (entry, vim_item)
				local word = entry:get_insert_text()
				if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet then
					word = vim.lsp.util.parse_snippet(word)
				end
				word = str.oneline(word)

				if
					entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
					and string.sub(vim_item.abbr, -1, -1) == "~"
				then
					word = word .. "~"
				end
				vim_item.abbr = word

				return vim_item
			end,
    })
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      -- elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { 'i', 's' }),
  },
  experimental = { ghost_text = false },
}
-- }}}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
