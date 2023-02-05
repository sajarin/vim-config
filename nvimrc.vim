" ====================================================================
" Author:        Shaedil D.
" Website Link:  https://github.com/Shaedil/vim-config
" Description:   My personal .vimrc used for TUI and GUI Vim/NVim
" Last Modified: 02/04/23
" ====================================================================
"{{{ Vim-Plug
call plug#begin('~/.vim/plugged')
" vim functionality
Plug 'junegunn/vim-plug'
Plug 'bronson/vim-visual-star-search'
Plug 'dstein64/vim-startuptime'
Plug 'tpope/vim-commentary'
Plug 't9md/vim-textmanip'
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'jiangmiao/auto-pairs'
" Plug 'tpope/vim-surround'
" vim git integration
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'mhinz/vim-signify'
" aesthetics / eye candy
Plug 'machakann/vim-highlightedyank'
Plug 'RRethy/vim-hexokinase', {'do': 'make hexokinase'}
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shaedil/undotree', { 'on': 'UndotreeToggle' }
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'tyrannicaltoucan/vim-quantum'
" Plug 'mhinz/vim-startify'
" other
Plug 'mattn/emmet-vim'
Plug 'vimwiki/vimwiki'
" For nvim
if has("nvim")
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'glepnir/zephyr-nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'jbyuki/venn.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'akinsho/bufferline.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'master' }
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'glepnir/dashboard-nvim'
endif
" mandatory to be last plugin to load
Plug 'ryanoasis/vim-devicons'
" More Vim
call plug#end()
"{{{ lua stuff
lua << EOF
require('bufferline').setup {
    options = {
        numbers = function(opts)
        return string.format('%s.', opts.ordinal)
        end,
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator_icon = '▎',
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        name_formatter = function(buf)
        if buf.name:match('%.md') then
            return vim.fn.fnamemodify(buf.name, ':t:r')
            end
        end,
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "("..count..")"
        end,
        offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}},
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
    }
}
EOF
"}}}
"}}}
"{{{ Tabs, foldmethods, syntax, etc
filetype plugin on
syntax on
set nocompatible
set encoding=utf8
set showcmd
set splitbelow
set splitright
set tags=tags
set visualbell
set synmaxcol=300
" automatically change directory to file location (kinda annoying
" sometimes, but necessary when dealing with a project)
set autochdir
" Don't give 'match 1 of 2' or 'The only match' messages
set shortmess+=c
" sets title of terminal to: '[filename] [+] (cwd) - NVIM'
set title
" number line
" set relativenumber
set number
set cursorline
" mouse support
set mouse=a
" folding
set foldmethod=marker
set foldnestmax=10
set foldenable
set foldlevelstart=0
" searching
set hlsearch
set incsearch
" pasting
set pastetoggle=<F2>
" indentation
set tabstop=4
set shiftwidth=4
set expandtab  " sets tabs to spaces
set softtabstop=0  " default
set autoindent
set smarttab
" autocompletion
set path=.,**
set wildmenu
set omnifunc=syntaxcomplete#Complete
set completeopt+=preview
set wildmode=longest:full
set wildcharm=<C-b>
set wildignore=*.swip,*.bak
set wildignore+=*.pyc,*.class,*.sln,*.Master,*.csproj,*.csproj.user
set wildignore+=*.cache,*.dll,*.pdb,*.min.*
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignore+=*.tar.*
"}}}
"{{{ Custom Functions, Commands and AutoCommands
command! BufOnly silent! execute "%bd|e#|bd#"
command! PrettifyJSON silent! execute "%!python3 -m json.tool"
" use map <buffer> to only map dd in the quickfix window. requires +localmap
command! RemoveQFItem :call RemoveQFItem()
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
command! VimwikiToQF :call VimwikiToQF()
command! RemoveAnswers :call RemoveAnswers()
" Remove Answers Function {{{
function! RemoveAnswers()
    " this is for multiline answers
    silent exec '%s/\(?\@<=.*\n\D.*\)//g'
    " this is for single line answers
    silent exec '%s/?\@<=\D.*//g'
    echo "ANSWERS REMOVED"
endfunction
"}}}
" Toggle Conceals {{{
function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction
nnoremap <silent> <C-c><C-y> :call ToggleConcealLevel()<CR>
"}}}
" Add checkboxes to *.wiki files{{{
call matchadd('Conceal', '\[\ \]', 0, 12, {'conceal': ''})
call matchadd('Conceal', '\[X\]', 0, 13, {'conceal': ''})
hi def link todoCheckbox Todo
hi! Conceal ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
setlocal conceallevel=2
"}}}
" Add Goyo integration to *.wiki files{{{
" silent execute Goyo
"}}}
" ToggleCursors{{{
nmap <F3> :call ToggleCursors()<CR>
fun! ToggleCursors()
    if &cursorline && &cursorcolumn
        set nocursorcolumn
        set nocursorline
    else
        set cursorcolumn
        set cursorline
    endif
endfun
"}}}
" Vullscreen {{{
:nnoremap <F11> :call VullScreen()<cr>
fun! VullScreen()
    if &go=~#'m'
        set go-=m
        set go-=T
        set go-=r
        set go-=R
        set go-=l
        set go-=L
    else
        set go+=m
        set go+=T
        set go+=r
        set go+=R
        set go+=l
        set go+=L
    endif
endfun
nnoremap <F4> :setlocal spell! spelllang=en_us<cr>
"}}}
" Use K to show documentation in preview window {{{
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
"}}}
" Viewing Images {{{
if has("unix")
    autocmd BufEnter *.png,*.jpg,*gif exec "!xdg-open ".expand("%") | :bw
endif
if has("win32")
    autocmd BufEnter *.png,*.jpg,*gif exec "!start ".expand("%") | :bw
endif
if has("mac")
    autocmd BufEnter *.png,*.jpg,*gif exec "!open ".expand("%") | :bw
endif
" }}}
" {{{ Vimwiki Links to QuickFixList
function! RemoveQFItem() abort
    let l:qf_list = getqflist()
    if len(l:qf_list) > 0
        let l:curqfidx = line('.') - 1
        call remove(l:qf_list, l:curqfidx)
        call setqflist(l:qf_list, 'r')
    endif
    if len(l:qf_list) > 0
        execute l:curqfidx + 1 . 'cfirst'
        copen
    else
        cclose
    endif
endfunction
function Delete_line_under_cursor()
    local curr_win = vim.api.nvim_get_current_win()
    local current_line = vim.api.nvim_win_get_cursor(curr_win)[1]
    local quickfix_length = vim.api.nvim_buf_get_var(0, 'quickfix_length')
    for i = 1, quickfix_length do
        local match = vim.api.nvim_list_get(0, '$', i)
        if match.lnum == current_line
            vim.api.nvim_list_del(0, '$', i)
            return
        endif
    endfor
    print("No quickfix line found under cursor")
endfunction
function! VimwikiToQF()
    exec ':vimgrep /\[\[[^https file].*\]\]/gj %'
    copen
    let l:num_of_matches_in_qf = line('$')
    for index in range(l:num_of_matches_in_qf)
        cc | exec ':VimwikiFollowLink'
        caddexpr expand("%") . ":" . line(1) . ":" . getline(1)
        bp | sp | bn | bd  "deletes current buffer and moves to previous buffer
        copen | call RemoveQFItem() | bd
    endfor
    exec ':VimwikiGoBackLink' | copen
endfunction

" }}}
"}}}
"{{{ Graphical config
" Font and Colorscheme{{{
set guifont=DroidSansMono\ NF:h11
set termguicolors
colorscheme zephyr
let g:quantum_black=1
let g:quantum_italics=1
let g:airline_theme='zenburn'
autocmd FileType python set colorcolumn=80
"}}}
"{{{ Webdevicon config
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_startify = 1
"}}}
"{{{ Airline Config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#ale#checking_symbol = " \uf252 "
let g:airline#extensions#coc#error_symbol = ' ⓧ '
let g:airline#extensions#coc#warning_symbol = ' ⚠️'
"}}}
"{{{ UndoTree config
let g:undotree_WindowLayout = 3
"}}}
"{{{ NERDTree config
let NERDTreeHighlightCursorline = 0
"}}}
"{{{ Ale Config
let g:ale_sign_error = "✘"
let g:ale_sign_warning = ""
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_linters = {'python': ['pylint', 'flake8', 'pycodestyle'], 'vimscript': ['vint']}
let g:ale_echo_msg_error = 'E'
let g:ale_echo_msg_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s'
highlight! ALEErrorSign ctermbg=NONE ctermfg=red guibg=NONE guifg=red
highlight! ALEWarningSign ctermbg=NONE ctermfg=yellow guibg=NONE guifg=yellow
highlight! ALEError ctermbg=NONE cterm=underline guifg=red gui=underline
highlight! ALEWarning ctermbg=NONE cterm=underline guifg=yellow gui=underline
"}}}
"{{{ Vimwiki Config
let wiki_1 = {}
let wiki_1.path = '~/vimwiki'
let wiki_1.index = 'index'
" let g:vimwiki_list = ['path': '~/vimwiki']
let g:vimwiki_list = [{'path': '~/vimwiki',
            \ 'template_path': '~/vimwiki_html/templates',
            \ 'template_default': 'default',
            \ 'template_ext': '.html'}]
autocmd BufNewFile, BufRead *.wiki setlocal nonu nornu nofoldenable
let g:vimwiki_folding = 'syntax'
"}}}
"" Startify Config {{{
"let g:startify_bookmarks = [
"   \ { 'c': '~/.vimrc' },
"   \ ]
"let g:startify_commands = [
"   \ { 'd': ['Vimwiki', ':VimwikiIndex'] },
"   \ ]
"let g:startify_lists = [
"   \ { 'type': 'files',     'header': ['   MRU']            },
"   \ { 'type': 'sessions',  'header': ['   Sessions']       },
"   \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
"   \ { 'type': 'commands',  'header': ['   Commands']       },
"   \ ]
"let g:startify_custom_header =
"   \ startify#pad(startify#fortune#cowsay('', '═','║','╔','╗','╝','╚'))
"let g:startify_custom_header_quotes =
"   \ startify#fortune#predefined_quotes() + [
"   \ ['What you can do is often simply a matter of what you will do', '', '- Norton Juster, Phantom Tollbooth'],
"   \ ["So many things are possible just as long as you don't know they're impossible", '', '- Norton Juster, Phantom Tollbooth'],
"   \ ['You must never feel badly about making mistakes... as long as you take the trouble to learn from them. For you often learn more by being wrong for the right reasons than you do by being right for the wrong reasons.', '', '- Norton Juster, Phantom Tollbooth'],
"   \ ["The only thing you can do easily is be wrong, and that's hardly worth the effort", '', '- Norton Juster, Phantom Tollbooth'],
"   \ ["But I suppose there's a lot to see if only you keep your eyes open", '', '- Norton Juster, Phantom Tollbooth'],
"   \ ["The most important reason for going from one place to another is to see what's in-between", '', '- Norton Juster, Phantom Tollbooth'],
"   \ ]
"let g:startify_custom_footer = [
"   \ '                                                                      ',
"   \ '                                           ^^                         ',
"   \ '      ^^      ..                                       ..             ',
"   \ '              []                                       []             ',
"   \ '            .:[]:_          ^^                       ,:[]:.           ',
"   \ '          .: :[]: :-.                             ,-: :[]: :.         ',
"   \ '        .: : :[]: : :`._                       ,.´: : :[]: : :.       ',
"   \ '      .: : : :[]: : : : :-._               _,-: : : : :[]: : : :.     ',
"   \ '  _..: : : : :[]: : : : : : :-._________.-: : : : : : :[]: : : : :-._ ',
"   \ '  _:_:_:_:_:_:[]:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:_:[]:_:_:_:_:_:_ ',
"   \ '  !!!!!!!!!!!![]!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!![]!!!!!!!!!!!!!',
"   \ '  ^^^^^^^^^^^^[]^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^[]^^^^^^^^^^^^^',
"   \ '              []                                       []             ',
"   \ '              []                                       []             ',
"   \ '              []                                       []             ',
"   \ '   ~~^-~^_~^~/  \~^-~^~_~^-~_^~-^~_^~~-^~_~^~-~_~-^~_^/  \~^-~_~^-~~- ',
"   \ '  ~ _~~- ~^-^~-^~~- ^~_^-^~~_ -~^_ -~_-~~^- _~~_~-^_ ~^-^~~-_^-~ ~^   ',
"   \ '     ~ ^- _~~_-  ~~ _ ~  ^~  - ~~^ _ -  ^~-  ~ _  ~~^  - ~_   - ~^_~  ',
"   \ '       ~-  ^_  ~^ -  ^~ _ - ~^~ _   _~^~-  _ ~~^ - _ ~ - _ ~~^ -      ',
"   \ '  New     ~^ -_ ~^^ -_ ~ _ - _ ~^~-  _~ -_   ~- _ ~^ _ -  ~ ^-   jgs  ',
"   \ '  York City   ~^~ - _ ^ - ~~~ _ - _ ~-^ ~ __- ~_ - ~  ~^_-            ',
"   \ '                  ~ ~- ^~ -  ~^ -  ~ ^~ - ~~  ^~ - ~                  ',
"   \ ]

""}}}
" CTRLP Config{{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"}}}
" COC Config {{{
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"}}}
" indentLine / indent_blankline.nvim Config {{{
let g:indentLine_char_list = ['│', '┊', '¦', '┊', '|']
let g:indentLine_faster = 1
let g:indentLine_setColors = 0
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', '*.wiki']
let g:indentLine_fileTypeExclude = ['vimwiki']
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'vimwiki']
set listchars=tab:\¦\ ,trail:■,extends:>,precedes:<,nbsp:+
set list
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_bufname_exclude = ['index.wiki']
let g:indent_blankline_buftype_exclude = ['terminal']
"}}}
" Emmet Config {{{
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
"}}}
"{{{ UndoTree Config
let g:undotree_TreeNodeShape='●'
let g:undotree_TreeVertShape='│'
let g:undotree_TreeDiagRightShape = '╱'
let g:undotree_TreeDiagLeftShape = '╲'
let g:undotree_CursorLine=0
let g:undotree_ShortIndicators=1
"}}}
"{{{ Dashboard config
let g:indentLine_fileTypeExclude = ['dashboard']
autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
command! SSave :SessionSave<CR>
command! SLoad :SessionLoad<CR>
let g:dashboard_default_executive = 'telescope'
let g:dashboard_session_directory = '~/AppData/Local/nvim-data/session'
let g:dashboard_custom_header = [
    \"  ___                      ______                                ░░░░░░░░░░░                          ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░   ░░░░░░░░░░",
    \" ( / \\                /)  (  /        _/_                ▄▄▄▄▄                                  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                 ",
    \"  /   /, , , __,  _   //    -/--__ _   /  _   _  (   (   █ ▄ ▄ █       ░░░░░░  ░░░░░░░░░░░       ▒▒▒▒▒▒▒▒      ▒▒▒▒▒▒▒▒        ░░░░░░░░",
    \"(/\\_/(_(_/_(_/(_/ (_//_   _/  (_)/ (_(__/ (_(/_/_)_/_)_ █▄▄▄▄▄█                                 ▒▒▒▒▒░░░           ▒▒▒▒▒                ",
    \"                    /)                                   ██▄█▄██  ░░░░░                          ▒▒▒▒▒░░░           ▒▒▒▒▒              ░░░░░   ░░░░░",
    \"                  (/                                      ▀▀██▀                              ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒                       ",
    \"                                                                 ░░░░░  ░░░   ░░░░░░░░░░░░░ ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒        ░░░░░░░░░░░░░",
    \"                                                                                            ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒                     ",
    \"                                                                                            ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒           ░░░░░░░░",
    \"                  ███████████                   ██████████████          ░░░░░░░░░░░░░░░░    ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒                  ",
    \"                  ███████████                   ██████████████                              ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒     ░░░   ░░░",
    \"                  █████████▒▒                   ██████████████       ░░░   ░░░              ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒             ",
    \"                  █████████▒▒                   ██████████████   ░░                         ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒         ░░░░░",
    \"     ░░░░░░░░░░░░░██████▒▒▒▒▒▒▒▒           ░░░░░███▒▒▒▒▒▒▒▒███▒▒▒                           ▒▒▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒             ",
    \"     ░░░░░░░░░░░░░██████▒▒▒▒▒▒▒▒           ░░░░░███▒▒▒▒▒▒▒▒███▒▒▒    ░░░░░░░░░░░░░░░░░░░░░░    ▒▒▒▒▒               ▒▒▒▒▒           ░░░░░░░░",
    \"     ░░░░░░░░▒▒▒▒▒▒▒▒▒██████████         ░░░░░░░██████████████▒▒▒▒▒          ████████          ▒▒▒▒▒               ▒▒▒▒▒               ",
    \"     ░░░░░░░░▒▒▒▒▒▒▒▒▒██████████         ░░░░░░░██████████████▒▒▒▒▒  ░░      ████████          ▒▒▒▒▒               ▒▒▒▒▒     ░░░░░░░░",
    \"     ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███████         ░░░░░░░░░████▒▒████▒▒▒▒▒▒▒▒▒      ███████          ░░░▒▒▒▒▒               ▒▒▒▒▒             ",
    \"     ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███████         ░░░░░░░░░████▒▒████▒▒▒▒▒▒▒▒▒      ███████          ░░░▒▒▒▒▒               ▒▒▒▒▒     ░░░░░░░░",
    \"     ░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███         ░░░░░░░░░██████████▒▒▒▒▒▒▒▒▒           ██          ▒▒▒▒▒▒▒▒               ▒▒▒▒▒                ░░░░",
    \"     ░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒  ░░░░░░░░░██████████▒▒▒▒▒▒▒▒▒░░░░░░░░█████          ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒                  ",
    \"     ░░░░░░░▒▒▒▒▒▒▒▒▒▒  ███▒▒▒▒▒▒▒▒▒▒▒▒▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄████▒▒▒  ▒▒▒▒████████████████          ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒          ░░░░░",
    \"     ░░░░░░░▒▒▒▒▒▒▒▒▒▒  ████████         ░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒           █████          ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒               ",
    \"            ▒▒▒▒▒▒▒▒▒▒  ████████         ░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒            ███",
    \"       ▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒                 ░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒          ███        NEOVIM 0.9.0-dev",
    \"       ▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒                        ▒▒▒▒▒▒▒      ▒▒▒▒▒▒",
    \"   ▒▒▒▒▒▒▒          ▒▒▒▒▒▒                      ▒▒▒▒▒▒▒      ▒▒▒▒▒▒▒▒▒",
    \" ▒▒▒▒▒                 ▒▒▒                   ▒▒▒▒▒▒               ▒▒▒▒▒▒",
    \" ▒▒▒▒▒                 ▒▒▒                   ▒▒▒▒▒▒               ▒▒▒▒▒▒▒▒▒",
    \"   ▒▒▒                 ▒▒▒▒▒▒             ▒▒▒▒▒▒▒▒▒                  ▒▒▒▒▒▒",
    \]
"}}}
"}}}
"{{{ Keybindings
" Abbreviations{{{
ca vsf vert sf
ca W w
ca Cd cd
ca Wq wq
"}}}
"Navigating split windows{{{
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
" for the terminal, see below
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
"}}}
"Adjusting split windows{{{
noremap <C-up> <C-w>+
noremap <C-down> <C-w>-
noremap <leader>] <C-w>>
noremap <leader>[ <C-w><
noremap <C-=> <C-w>=
noremap <C-_> <C-w>_
"}}}
"Navigating Tabs{{{
" gt is default
nnoremap gt :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
"}}}
"Buffer management{{{
nnoremap gb :ls<Cr>:b<Space>
map <C-Right> :bnext<CR>
map <C-Left> :bprev<CR>
"}}}
"NERDTree mapping{{{
noremap <C-N> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
"}}}
""UNDOTree mapping{{{
"noremap <C-U> :UndotreeToggle<CR>
""}}}
"TEXTMANIP Mappings{{{
let g:textmanip_enable_mappings = 1
xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)
" toggle insert/replace with <F10>
nmap <F9> <Plug>(textmanip-toggle-mode)
xmap <F9> <Plug>(textmanip-toggle-mode)
"}}}
" Tagbar mappings {{{
nmap <F8> :TagbarToggle<CR>
"}}}
" Git conflict management {{{
" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
"}}}
" Replace all is aliased to S {{{
nnoremap S :%s//g<Left><Left>
" }}}
" barbar mappings {{{
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
"}}}
"{{{ venn.nvim mappings
xmap <leader>b :VBox<CR>
"}}}
"}}}
"{{{ Vim airline config
set noshowmode
" "\uf6da use for tabline on top left or top right for total bufnr
" if has ("gui_running")
"     let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . '%{col(".")}' . "\uE0A3"])
" endif
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"{{{ Unicode symbols depending on font
" let g:airline_left_sep = "\uE0B8"
" let g:airline_left_alt_sep = "\uE0B9"
" let g:airline_right_sep = "\uE0Ba"
" let g:airline_right_alt_sep = "\uE0Bb"
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.notexists = ' '
" let g:airline_symbols.whitespace = 'Ξ'
"}}}
" Powerline symbols if using powerline font{{{
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰ '
let g:airline_symbols.maxlinenr = ''
"}}}
"}}}
""{{{ Custom Statusline by kristijanhusak
"scriptencoding utf-8
"let s:cache = {'branch': ''}

"augroup custom_statusline
"    autocmd!
"    autocmd VimEnter * silent! call FugitiveDetect(expand('<afile>')) | let s:cache.branch = fugitive#head()
"    autocmd BufEnter,WinEnter * setlocal statusline=%!Statusline()
"    autocmd BufLeave,WinLeave * setlocal statusline=%f\ %y\ %m
"    autocmd User FugitiveChanged let s:cache.branch = fugitive#head()
"    autocmd VimEnter,ColorScheme * call s:set_statusline_colors()
"augroup END

"function! s:set_statusline_colors() abort
"    let s:normal_bg = synIDattr(hlID('Normal'), 'bg')
"    let s:normal_fg = synIDattr(hlID('Normal'), 'fg')
"    let s:warning_fg = synIDattr(hlID(&background ==? 'dark' ? 'GruvboxYellow' : 'WarningMsg'), 'fg')
"    let s:error_fg = synIDattr(hlID('ErrorMsg'), &background ==? 'dark' ? 'bg' : 'fg')
"    silent! exe 'hi StItem guibg='.s:normal_fg.' guifg='.s:normal_bg.' gui=NONE'
"    silent! exe 'hi StSep guifg='.s:normal_fg.' guibg=NONE gui=NONE'
"    silent! exe 'hi StErr guibg='.s:error_fg.' guifg='.s:normal_bg.' gui=bold'
"    silent! exe 'hi StErrSep guifg='.s:error_fg.' guibg=NONE gui=NONE'
"    silent! exe 'hi StWarn guibg='.s:warning_fg.' guifg='.s:normal_bg.' gui=bold'
"    silent! exe 'hi StWarnSep guifg='.s:warning_fg.' guibg=NONE gui=NONE'
"    silent! exe 'hi Statusline guifg=NONE guibg='.s:normal_bg.' gui=NONE cterm=NONE'
"endfunction

"function! s:sep(item, ...) abort
"    let l:opts = get(a:, '1', {})
"    let l:before = get(l:opts, 'before', ' ')
"    let l:sep_color = get(l:opts, 'sep_color', '%#StSep#')
"    let l:color = get(l:opts, 'color', '%#StItem#')

"    return l:before.l:sep_color.'█'.l:color.a:item.l:sep_color.'█%*'
"endfunction

"function! s:sep_if(item, condition, ...) abort
"    if !a:condition
"        return ''
"    endif
"    let l:opts = get(a:, '1', {})
"    return s:sep(a:item, l:opts)
"endfunction

"let s:st_err = {'color': '%#StErr#', 'sep_color': '%#StErrSep#'}
"let s:st_warn = {'color': '%#StWarn#', 'sep_color': '%#StWarnSep#'}
"let s:st_mode = {'color': '%#StMode#', 'sep_color': '%#StModeSep#'}

"function! Statusline() abort
"    let l:mode = s:mode_statusline()
"    let l:statusline = s:sep(l:mode, extend({'before': ''}, s:st_mode))
"    let l:git_status = s:git_statusline()
"    let l:statusline .= s:sep_if(l:git_status, !empty(l:git_status))
"    let l:path = isdirectory(expand('%')) ? '%F': '%f' . " " . WebDevIconsGetFileFormatSymbol()
"    let l:statusline .= s:sep(l:path, &modified ? s:st_err : {})                  "File path
"    let l:statusline .= s:sep_if(' + ', &modified, s:st_err)                      "Modified indicator
"    let l:statusline .= s:sep_if(' - ', !&modifiable, s:st_err)                   "Modifiable indicator
"    let l:statusline .= s:sep_if('%w', &previewwindow)                            "Preview indicator
"    let l:statusline .= s:sep_if('%r', &readonly)                                 "Read only indicator
"    let l:statusline .= s:sep_if('%q', &buftype ==? 'quickfix')                   "Quickfix list indicator
"    let l:statusline .= '%='                                                      "Start right side layout
"    let l:ft = &filetype . " " . WebDevIconsGetFileTypeSymbol()
"    let l:statusline .= s:sep_if(l:ft, !empty(l:ft))                              "Filetype
"    let l:statusline .= s:sep(': %c', s:st_mode)                                "Column number
"    let l:statusline .= s:sep(': %l/%L', s:st_mode)                              "Current line number/Total line numbers
"    let l:statusline .= s:sep('%p%%', s:st_mode)                                  "Percentage
"    let l:err = s:ale_status('error')
"    let l:warn = s:ale_status('warning')
"    let l:statusline .= s:sep_if(l:err, !empty(l:err), s:st_err)
"    let l:statusline .= s:sep_if(l:warn, !empty(l:warn), s:st_warn)
"    let l:statusline .= '%<'
"    return l:statusline
"endfunction

"function! s:ale_status(type) abort
"    if !exists('g:loaded_ale')
"        return ''
"    endif

"    let l:count = ale#statusline#Count(bufnr(''))
"    let l:errors = l:count.error + l:count.style_error
"    let l:warnings = l:count.warning + l:count.style_warning

"    if a:type ==? 'error' && l:errors
"        return printf('%d E', l:errors)
"    endif

"    if a:type ==? 'warning' && l:warnings
"        return printf('%d W', l:warnings)
"    endif

"    return ''
"endfunction

"function! s:git_statusline() abort
"    if !exists('b:gitgutter')
"        return s:with_icon(s:cache.branch, "\ue0a0")
"    endif
"    let [l:added, l:modified, l:removed] = get(b:gitgutter, 'summary', [0, 0, 0])
"    let l:result = l:added == 0 ? '' : ' +'.l:added
"    let l:result .= l:modified == 0 ? '' : ' ~'.l:modified
"    let l:result .= l:removed == 0 ? '' : ' -'.l:removed
"    let l:result = join(filter([s:cache.branch, l:result], {-> !empty(v:val) }), '')
"    return s:with_icon(l:result, "\ue0a0")
"endfunction

"function! s:mode_statusline() abort
"    let l:mode = mode()
"    call s:mode_highlight(l:mode)
"    let l:modeMap = {
"    \ 'n'  : 'NORMAL',
"    \ 'i'  : 'INSERT',
"    \ 'R'  : 'REPLACE',
"    \ 'v'  : 'VISUAL',
"    \ 'V'  : 'V-LINE',
"    \ 'c'  : 'COMMAND',
"    \ '' : 'V-BLOCK',
"    \ 's'  : 'SELECT',
"    \ 'S'  : 'S-LINE',
"    \ '' : 'S-BLOCK',
"    \ 't'  : 'TERMINAL',
"    }
"    return get(l:modeMap, l:mode, 'UNKNOWN')
"endfunction

"function! s:mode_highlight(mode) abort
"    if a:mode ==? 'i'
"        " hi StMode guibg=#83a598 guifg=#3c3836
"        hi StMode guibg=#39BAE6 guifg=#3c3836
"        hi StModeSep guifg=#39BAE6 guibg=NONE
"    elseif a:mode =~? '\(v\|V\|\|s\|S\|\)'
"        " hi StMode guibg=#fe8019 guifg=#3c3836
"        hi StMode guibg=#FF8F40 guifg=#3c3836
"        hi StModeSep guifg=#FF8F40 guibg=NONE
"    elseif a:mode ==? 'R'
"        " hi StMode guibg=#8ec07c guifg=#3c3836
"        hi StMode guibg=#FF3333 guifg=#3c3836
"        hi StModeSep guifg=#FF3333 guibg=NONE
"    else
"        silent! exe 'hi StMode guibg='.s:normal_fg.' guifg='.s:normal_bg.' gui=NONE'
"        silent! exe 'hi StModeSep guifg='.s:normal_fg.' guibg=NONE gui=NONE'
"    endif
"endfunction

"function! s:with_icon(value, icon) abort
"    if empty(a:value)
"        return a:value
"    endif
"    return a:icon.' '.a:value
"endfunction
""}}}
cd ~
" let @9='vipJ'
" vnoremap . :normal .<CR>
" nnoremap <leader>` @9
" vnoremap <leader>` :g/\n\n/normal 2k@9<CR>
 
" vim: ts=2 sts=2 sw=2 et
