--┌─────────────────────────────────────────────────────────────────┐
--│ Author:        Shaedil D.                                       │
--│ Maintainer:    Shaedil D.                                       │
--│ Website Link:  https://github.com/Shaedil/vim-config            │
--│ Description:   My personal .vimrc used for TUI and GUI Vim/NVim │
--│ Last Modified: 1/5/23                                           │
--└─────────────────────────────────────────────────────────────────┘

-- [[ Packer ]] {{{
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[packadd packer.nvim]]
end
--- }}}
-- [[ Plugins ]] {{{
require('packer').startup(function(use)
  -- packer.nvim {{{
  use 'wbthomason/packer.nvim'
  --- }}}
  -- LSP Configuration & Plugins {{{
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim',
    },
  }
  --}}}
  -- nvim-cmp & autocompletion {{{
  use { -- Autocompletion
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }
  --- }}}
  -- nvim-treesitter {{{
  use { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  -- }}}
  -- nvim-treesitter additional text objects {{{
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  -- }}}
  -- Gitsigns.nvim, vim-fugitive, vim-rhubarb {{{
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'
  -- }}}
  -- lualine.nvim {{{
  use {
    'nvim-lualine/lualine.nvim', -- Fancier statusline
    requires = {'kyazdani42/nvim-web-devicons', opt=true }
  }
  -- }}}
  -- indent-blankline.nvim {{{
  use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
  -- }}}
  -- Comment.nvim {{{
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  -- }}}
  -- vim-sleuth {{{
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  -- }}}
  -- vimwiki, venn.nvim {{{
  use 'vimwiki/vimwiki'
  use 'jbyuki/venn.nvim'
  -- }}}
  -- startup time {{{
  use 'dstein64/vim-startuptime'
  -- }}}
  -- colorschemes {{{
  use 'navarasu/onedark.nvim' -- Theme inspired by Atom
  use 'glepnir/zephyr-nvim' -- My preferred colorscheme
  -- }}}
  -- telescope.nvim, plenary.nvim {{{
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  -- }}}
  -- telescope-fzf-native.nvim {{{
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'}
  -- }}}
  -- visual-star-search {{{
  use 'bronson/vim-visual-star-search'
  -- }}}
  -- custom plugins {{{
  -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
  local has_plugins, plugins = pcall(require, 'custom.plugins')
  if has_plugins then
    plugins(use)
  end

  if is_bootstrap then
    require('packer').sync()
  end
  --- }}}
end)
---}}}
-- [[ Bootstrap config message ]] {{{
-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end
--}}}
-- [[ Auto compile init.lua on save ]] {{{
-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})
--}}}
-- [[ Vim Settings ]] {{{
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false
-- Make line numbers default
vim.wo.number = true
-- Enable mouse mode
vim.o.mouse = 'a'
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]
-- Set font
vim.opt.guifont = {"DroidSansMono NF:h11"}
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- Fold settings
vim.o.foldmethod = 'marker'
vim.o.foldnestmax = 10
vim.o.foldenable = true
vim.o.foldlevelstart = 0
-- Change default directory to home directory.
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- }}}
-- [[ Highlight on yank ]] {{{
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- }}}

-- [[ Bubbles config for lualine ]] {{{
-- Author: lokesh-krishna
-- MIT license
require('lualine').setup {
  options = {
    theme = 'onedark',
    component_separators = '|',
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
---}}}
-- [[ Comment.nvim Config ]] {{{
require('Comment').setup()
--- }}}
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
  filetype_exclude = {"dashboard", "packer", "NvimTree", "lsp-installer", "lspinfo", "checkhealth", "help", "man", ""},
  buftype_exclude = {"terminal"},
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
  numhl = false,
  linehl = false,
  keymaps = {noremap = true, buffer = true},
  watch_gitdir = {interval = 1000},
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil
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
      width = 0.75,
      preview_cutoff = 120,
      horizontal = {mirror = false},
      vertical = {mirror = false}
    },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
    color_devicons = true,
    use_less = true,
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
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

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

-- [[ Keymappings ]] {{{
-- See `:help vim.keymap.set()`

-- sets space as <leader> instead of actual leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Custom mappings {{{
-- Mappings for telescope {{{
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move cursor to window below' })
-- }}}
-- Split window nav{{{
vim.keymap.set('n', '<C-H>', '<C-W><C-H>', { desc = 'Move cursor to window left of current' })
vim.keymap.set('n', '<C-J>', '<C-W><C-J>', { desc = 'Move cursor to window below current' })
vim.keymap.set('n', '<C-K>', '<C-W><C-K>', { desc = 'Move cursor to window above current' })
vim.keymap.set('n', '<C-L>', '<C-W><C-L>', { desc = 'Move cursor to window right of current' })
-- }}}
-- Terminal nav {{{
vim.keymap.set('t', '<C-W>h', '<C-\\><C-N><C-W>h', { desc = 'Move cursor from terminal to left window' })
vim.keymap.set('t', '<C-W>j', '<C-\\><C-N><C-W>j', { desc = 'Move cursor from terminal to window below' })
vim.keymap.set('t', '<C-W>k', '<C-\\><C-N><C-W>k', { desc = 'Move cursor from terminal to window above' })
vim.keymap.set('t', '<C-W>l', '<C-\\><C-N><C-W>l', { desc = 'Move cursor from terminal to right window' })
-- }}}
-- Split window size {{{
vim.keymap.set('n', '<C-up>', '<C-w>+', { desc = 'Vertically size [UP] the current window' })
vim.keymap.set('n', '<C-down>', '<C-w>-', { desc = 'Vertically size [DOWN] the current window' })
vim.keymap.set('n', '<leader>]', '<C-w>>', { desc = 'Horizontally increase size of current window' })
vim.keymap.set('n', '<leader>[', '<C-w><', { desc = 'Horizontally decrease size of current window' })
vim.keymap.set('n', '<C-=>', '<C-w>=', { desc = '[=]alize all windows in current tab' })
vim.keymap.set('n', '<C-_>', '<C-W>_', { desc = 'Maximize current window size in current tab' })
-- }}}
-- Tab nav {{{
-- gt is default 
vim.keymap.set('n', 'gt', ':tabnext<CR>', { desc = '[G]o [T]o next tab page' })
vim.keymap.set('n', 'th', ':tabprev<CR>', { desc = '[T]ab to previous tab page' })
vim.keymap.set('n', 'tn', ':tabnew<CR>', { desc = 'Make a [T]ab that is [N]ew' })
vim.keymap.set('n', 'tc', ':tabclose<CR>', { desc = 'Make current [T]ab [C]losed' })
-- }}}
-- Buffer nav {{{
vim.keymap.set('n', 'gb', ':ls<CR>:b<Space>', { desc = '[G]o to [B]uffer' })
vim.keymap.set('n', 'C-Right', ':bnext<CR>', { desc = 'Move [RIGHT] to next buffer' })
vim.keymap.set('n', 'C-Left', ':bprev<CR>', { desc = 'Move [LEFT] to prev buffer' })
-- }}}
-- Move Text up or down  {{{
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selected text down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selected text up' })

-- }}}
-- Git conflict management {{{
-- Fugitive Conflict Resolution
vim.keymap.set('n', '<leader>gd', ':Gvdiff<CR>', { desc = 'Start [G]it [D]iff' })
vim.keymap.set('n', 'gdh', ':diffget //2<CR>', { desc = 'Accept change from left in [G]it [D]iff' })
vim.keymap.set('n', 'gdl', ':diffget //3<CR>', { desc = 'Accept change from right in [G]it [D]iff' })
-- }}}
-- Replace all is aliased to S {{{
vim.keymap.set('n', 'S', ':%s//g<Left><Left>', { desc = '[S]ubstitute and replace in buffer' })
-- }}}
-- venn.nvim mappings {{{
vim.keymap.set('x', '<leader>b', ':VBox<CR>',   { desc = 'Venn.nvim create [B]ox' })
-- }}}
-- Diagnostic keymaps {{{
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
-- }}}
-- }}}
-- }}}

-- [[ LSP settings ]] {{{
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
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
  nmap('<leader>k>', vim.lsp.buf.signature_help, 'Signature Documentation')

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

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
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

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

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
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- }}}

-- [[ Start directory to $USERPROFILE ]] {{{
-- Change default working directory when neovim starts
local os = require("os")
local path_to_home = os.getenv("USERPROFILE")
local vim_enter_group = vim.api.nvim_create_augroup("vim_enter_group", {clear = true})
vim.api.nvim_create_autocmd(
  {"VimEnter"},
  { pattern = "*", command = "cd " .. path_to_home, group = vim_enter_group }
)
-- }}}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
