--┌──────────────────────────────────────────────────────────────────┐
--│ Author:        Shaedil D.                                        │
--│ Website Link:  https://github.com/Shaedil/vim-config             │
--│ Description:   Edited version of nvim-lua/kickstart.nvim         │
--│ Last Modified: 1/22/23                                           │
--└──────────────────────────────────────────────────────────────────┘
-- [[ lazy.nvim Bootstrap ]] {{{
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
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
--- }}}
-- [[ Plugins ]] {{{
require("lazy").setup({
  'folke/neodev.nvim',
  {'neovim/nvim-lspconfig', dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'j-hui/fidget.nvim', 'folke/neodev.nvim' }},
  {'hrsh7th/nvim-cmp', dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' }},
  {'tpope/vim-fugitive', cmd = 'Git'},
  {'tpope/vim-rhubarb', dependencies = { 'tpope/vim-fugitive' }},
  {'numToStr/Comment.nvim'},
  {'tpope/vim-sleuth'},
  {'vimwiki/vimwiki', keys = "<leader>ww"},
  {'lewis6991/impatient.nvim'},
  {'bronson/vim-visual-star-search', keys = { '*', '#', '<leader>*' }},
  {'ThePrimeagen/harpoon'},
  {'tpope/vim-speeddating', },
  {'goolord/alpha-nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
  {'mbbill/undotree', keys = "<leader>u"},
  {'rebelot/kanagawa.nvim'},
  {'lukas-reineke/indent-blankline.nvim'},
  {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
  {'lewis6991/gitsigns.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  {'nvim-treesitter/nvim-treesitter', build = ':pcall(require("nvim-treesitter.install").update { with_sync = true })'},
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, branch = '0.1.x'},
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'},
  {'nvim-telescope/telescope-project.nvim'},
})
-- }}}
-- [[ Auto compile init.lua on save ]] {{{
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | silent! LspStop | silent! LspStart', pattern = vim.fn.expand '$MYVIMRC' })
--}}}
-- [[ Vim Settings ]] {{{
-- See `:help vim.o`
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.visualbell = true
vim.opt.autochdir = true
vim.opt.shortmess:append('c')
-- searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- mouse support
vim.opt.mouse = 'a'
-- gui settings
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.title = true
vim.opt.laststatus = 3
vim.opt.fillchars:append({ horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┨', vertright = '┣', verthoriz = '╋' })
vim.opt.conceallevel = 2
vim.o.t_Co = 256
vim.opt.signcolumn = 'yes'
vim.opt.background = 'dark'
vim.opt.guifont = "JetBrainsMono NFM:h10"
-- optimizations
vim.opt.breakindent = true
vim.go.lazyredraw = false
vim.opt.synmaxcol = 300
vim.go.updatetime = 250
-- autocompletion + path + undo
vim.opt.path = '.,**'
vim.opt.completeopt:append('preview')
vim.go.wildmode = 'longest:full'
vim.go.wildignore = "*.swip, *.bak, *.pyc, *.class, *.sln, *.Master, *.csproj, *.csproj.user, *.cache, *.dll, *.pdb, *.min.*, */.git/**/*, */.hg/**/*, */.svn/**/*, tags, *.tar.*"
vim.opt.undofile = true
-- Fold settings
vim.opt.foldmethod = 'marker'
vim.opt.foldnestmax = 10
vim.opt.foldenable = true
vim.opt.foldlevelstart = 0
-- Set <space> as the leader key
-- }}}
-- [[ Config ]] {{{
-- [[ Bubbles config for lualine ]] {{{
-- Author: lokesh-krishna
-- MIT license
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = '│',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = { 'fileformat' },
    lualine_x = { 'diff', 'diagnostics' },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
-- }}}
-- [[ alpha.nvim Config ]] {{{
require('alpha').setup(require('alpha.themes.dashboard').config)
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.val = {
  [[                                                   ]],
  [[                                              ___  ]],
  [[                                           ,o88888 ]],
  [[       Neovim                           ,o8888888' ]],
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
  [[  . . . ...."'                    Saturn           ]],
  [[  .. . ."'                                         ]],
  [[ .                                                 ]],
  [[                                                   ]],
}
dashboard.section.buttons.val = {
  dashboard.button("SPC f", "  Find file", ":Telescope find_files <CR>"),
  dashboard.button("SPC e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("SPC p", "  Find project", ":Telescope projects <CR>"),
  dashboard.button("SPC r", "  Recently used files", ":Telescope oldfiles <CR>"),
  dashboard.button("SPC c", "  Configuration", ":e $MYVIMRC <CR>"),
  dashboard.button("SPC q", "  Quit Neovim", ":qa<CR>"),
}
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
vim.cmd([[autocmd User AlphaReady echo 'ready']])
-- }}}
-- [[ Vimwiki Config ]] {{{
local wiki_1 = {}
wiki_1.path = '~/vimwiki'
wiki_1.index = 'index'
vim.g.vimwiki_list = {{
  path = '~/vimwiki',
  template_path = '~/vimwiki_html/templates',
  template_default = 'default',
  template_ext = '.html'
}}
vim.api.nvim_command("autocmd BufNewFile,BufRead *.wiki setlocal nonu nornu nofoldenable")
vim.g.vimwiki_folding = 'syntax'
vim.api.nvim_set_hl(0, "VimwikiHeader1", {fg="#98BB6C"}) -- spring green
vim.api.nvim_set_hl(0, "VimwikiHeader2", {fg="#FF5D62"}) -- peach red
vim.api.nvim_set_hl(0, "VimwikiHeader3", {fg="#FFA066"}) -- surimi orange
vim.api.nvim_set_hl(0, "VimwikiHeader4", {fg="#7FB4CA"}) -- crystal blue
vim.api.nvim_set_hl(0, "VimwikiHeader5", {fg="#957FB8"}) -- oni violet
vim.api.nvim_set_hl(0, "VimwikiHeader6", {fg="#D27E99"}) -- sakura pink
-- }}}
-- [[ Rainbow colored indentations ]] {{{
local function get_char_highlights()
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD blend=nocombine]]
  return {
    "IndentBlanklineIndent1", "IndentBlanklineIndent2", "IndentBlanklineIndent3", "IndentBlanklineIndent4", "IndentBlanklineIndent5",
    "IndentBlanklineIndent6"
  }
end
---}}}
-- [[ Indent-blankline Config ]] {{{
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
  filetype_exclude = {"alpha", "dashboard", "packer", "vimwiki", "NvimTree", "lsp-installer", "lspinfo", "checkhealth", "help", "man", "mason", "lua", ""},
  buftype_exclude = {"terminal", "_.*"},
  char_highlight_list = get_char_highlights(),
  context_patterns = {
    "class", "return", "function", "method", "^if", "^while", "jsx_element", "^for", "^object", "^table", "block", "arguments", "if_statement",
    "else_clause", "jsx_element", "jsx_self_closing_element", "try_statement", "catch_clause", "import_statement", "operation_type"
  }
}
--- }}}
-- [[ Gitsigns Config ]] {{{
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = {hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn'},
    change = {hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
    delete = {hl = 'GitSignsDelete', text = '▎', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
    topdelete = {hl = 'GitSignsDelete', text = '▎', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'}
  },
  signcolumn = true,
  numhl = false,
  linehl = false,
  word_diff = false,
  keymaps = {noremap = true, buffer = true},
  watch_gitdir = {interval = 1000, follow_files = true},
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil,
  attach_to_untracked = true,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = { relative_time = false },
  max_file_length = 40000,
  preview_config = {
    -- options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = { enable = false},
}
--- }}}
-- [[ Telescope Config ]] {{{
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
      vertical = {mirror = false},
      horizontal = {mirror = false}
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
    borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
    color_devicons = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case" -- or "ignore_case" or "respect_case"
      }
    },
  }
}
--- }}}
-- [[ Telescope fzf Config ]] {{{
-- Enable Telescope extensions
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'harpoon')

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
-- [[ Treesitter Config ]] {{{
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
--}}}
-- [[ Colorscheme Kanagawa Config ]] {{{
require('kanagawa').setup({ globalStatus = true })
vim.cmd("colorscheme kanagawa")
vim.cmd [[hi WinSeparator guibg=NONE guifg=#363646]]
-- }}}
-- [[ UndoTree Config ]] {{{
vim.g.undotree_WindowLayout = 3
vim.g.undotree_TreeNodeShape = '●'
vim.g.undotree_TreeVertShape = '│'
vim.g.undotree_TreeSplitShape = '╱'
vim.g.undotree_TreeReturnShape = '╲'
-- }}}
-- [[ LSP Signs Config ]] {{{
local signs = { Error = "✘ ", Warn = "⚠️ ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
-- }}}
-- [[ neodev + Mason Config ]] {{{
require('neodev').setup()
require('mason').setup()
-- }}}
-- [[ Telescope project Config ]] {{{
require'telescope'.load_extension('project')
-- }}}
-- [[ Comment.nvim Config ]] {{{
require('Comment').setup()
-- }}}
-- [[ impatient.nvim Config ]] {{{
require'impatient'
-- }}}
-- [[ Harpoon Config ]] {{{
require('harpoon').setup({
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,
    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,
    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,
    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,
    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },
    -- set marks specific to each git branch inside git repository
    mark_branch = false,
  }
})
-- }}}
-- }}}
-- [[ Keymappings ]] {{{
-- See `:help vim.keymap.set()`
-- aliases vim.keymap.set() to respective vim functions
-- sets space as <leader> instead of actual leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap 
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Mappings for telescope
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sp', require('telescope').extensions.project.project, { desc = '[S]earch [P]rojects' })
-- Split window nav
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { desc = 'Move cursor to window left of current' })
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move cursor to window below current' })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { desc = 'Move cursor to window above current' })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { desc = 'Move cursor to window right of current' })
-- Terminal nav
vim.keymap.set('t', '<C-W>h', '<C-\\><C-N><C-W>h', { desc = 'Move cursor from terminal to left window' })
vim.keymap.set('t', '<C-W>j', '<C-\\><C-N><C-W>j', { desc = 'Move cursor from terminal to window below' })
vim.keymap.set('t', '<C-W>k', '<C-\\><C-N><C-W>k', { desc = 'Move cursor from terminal to window above' })
vim.keymap.set('t', '<C-W>l', '<C-\\><C-N><C-W>l', { desc = 'Move cursor from terminal to right window' })
-- Split window size
vim.keymap.set('n', '<C-up>', '<C-w>+', { desc = 'Vertically size [UP] the current window' })
vim.keymap.set('n', '<C-down>', '<C-w>-', { desc = 'Vertically size [DOWN] the current window' })
vim.keymap.set('n', '<leader>]', '<C-w>>', { desc = 'Horizontally increase size of current window' })
vim.keymap.set('n', '<leader>[', '<C-w><', { desc = 'Horizontally decrease size of current window' })
vim.keymap.set('n', '<C-=>', '<C-w>=', { desc = '[=]alize all windows in current tab' })
vim.keymap.set('n', '<C-_>', '<C-W>_', { desc = 'Maximize current window size in current tab' })
-- Tab nav gt is default 
vim.keymap.set('n', 'gt', '<cmd>tabnext<CR>', { desc = '[G]o [T]o next tab page' })
vim.keymap.set('n', 'th', '<cmd>tabprev<CR>', { desc = '[T]ab to previous tab page' })
vim.keymap.set('n', 'tn', '<cmd>tabnew<CR>', { desc = 'Make a [T]ab that is [N]ew' })
vim.keymap.set('n', 'tc', '<cmd>tabclose<CR>', { desc = 'Make current [T]ab [C]losed' })
-- Buffer nav 
vim.keymap.set('n', 'gb', '<cmd>ls<CR>:b<Space>', { desc = '[G]o to [B]uffer' })
vim.keymap.set('n', 'C-Right', '<cmd>bnext<CR>', { desc = 'Move [RIGHT] to next buffer' })
vim.keymap.set('n', 'C-Left', '<cmd>bprev<CR>', { desc = 'Move [LEFT] to prev buffer' })
-- Move Text up or down 
vim.keymap.set('v', "K", "<cmd>m '<-2<CR>gv=gv", { desc = 'Move selected text up' })
vim.keymap.set('v', "J", "<cmd>m '>+1<CR>gv=gv", { desc = 'Move selected text down' })
-- Fugitive Conflict Resolution
-- based on: https://medium.com/prodopsio/solving-git-merge-conflicts-with-vim-c8a8617e3633
vim.keymap.set('n', '<leader>gd', '<cmd>Gvdiff<CR>', { desc = 'Start [G]it vertical [D]iff' })
vim.keymap.set('n', 'gdh', '<cmd>diffget //2<CR>', { desc = 'Accept change from left (HEAD) in [G]it [D]iff' })
vim.keymap.set('n', 'gdl', '<cmd>diffget //3<CR>', { desc = 'Accept change from right (master) in [G]it [D]iff' })
-- Replace all is aliased to S
vim.keymap.set('n', 'S', ':%s//g<Left><Left>', { desc = '[S]ubstitute and replace in buffer' })
-- undotree mappings 
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<cr>', { desc = "Toggle undotree" })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- }}}
-- [[ Custom Functions, Commands & Autocommands ]] {{{
vim.api.nvim_create_user_command('BufOnly', "%bd|e#|bd#", {})
-- [[ Highlight on yank ]] {{{
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
vim.api.nvim_command("call matchadd('Conceal', '\\[\\ \\]', 0, 12, {'conceal': '' })")
vim.api.nvim_command("call matchadd('Conceal', '\\[X\\]', 0, 13, {'conceal': '' })")
vim.api.nvim_command("hi def link todoCheckbox Todo")
vim.api.nvim_set_hl(0, 'Conceal', {ctermbg = 'NONE', ctermfg = 'NONE', bg = 'NONE', fg = 'NONE'})
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
-- }}}
-- [[ LSP settings ]] {{{
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local lspnmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  lspnmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  lspnmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  lspnmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  lspnmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  lspnmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  lspnmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  lspnmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  lspnmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  lspnmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  lspnmap('<leader>k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  lspnmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  lspnmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  lspnmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  lspnmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

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
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
      else fallback() end
    end, { 'i', 's' }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then luasnip.jump(-1)
      else fallback() end
    end, { 'i', 's' }),
  },
  sources = { { name = 'nvim_lsp' }, { name = 'luasnip' } },
}
-- }}}
vim.api.nvim_set_current_dir("~")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
