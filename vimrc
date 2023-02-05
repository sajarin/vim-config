" ===================================================================
" Author:        Shaedil D.
" Website Link:  https://github.com/Shaedil/vim-config
" Description:   Feature rich vimrc used for TUI and GUI Vim
" Last Modified: 2/04/23
" ===================================================================
"{{{ Vim-Plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'      " minimalist vim plugin manager
Plug 'tpope/vim-fugitive'     " git wrapper so awesome, it should be illegal
Plug 'tpope/vim-commentary'   " comment stuff out at the speed of thought
Plug 't9md/vim-textmanip'     " move/duplicate text intuitively
Plug 'w0rp/ale'               " Asynchronous linting engine for vim
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'     " quoting/parenthesizing made simple
Plug 'vimwiki/vimwiki' { 'on': 'VimwikiIndex'}
Plug 'ctrlpvim/ctrlp.vim'     " full path fuzzy file, buffer, mru, tag finder
Plug 'mhinz/vim-startify'     " fancy start screen for vim
Plug 'ryanoasis/vim-devicons' " adds icons to your plugins
call plug#end()
"}}}
"{{{ Tabs, foldmethods, syntax
filetype plugin on
syntax on
set nocompatible
set encoding=utf8
set splitbelow
set splitright
set tags=tags
set cursorline
set synmaxcol=0
" numberline
set nonumber
set relativenumber
set pastetoggle=<F2>
" for temporary mouse support
set mouse=a
" correct MacOS backspace key
set backspace=indent,eol,start
" indentation
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=0
set autoindent
" file search
set hlsearch
set incsearch
" folding
set foldmethod=marker
set foldnestmax=10
set foldenable
set foldlevelstart=0
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
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
            \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"}}}
"{{{ Custom Functions, Commands, and AutoCommands
command! BufOnly silent! execute "%bd|e#|bd#"
"{{{ ToggleCursors - Useful for when you forget where your cursor is
nmap <F3> :call ToggleCursors()<CR>
fun! ToggleCursors()
    if &cursorline && &cursorcolumn
        set nocursorcolumn nocursorline
    else
        set cursorcolumn cursorline
    endif
endfun
"}}}
"{{{ Viewing Images
if has("unix")
    autocmd BufEnter *.png,*.jpg,*gif exec "!xdg-open ".expand("%") | :bw
endif
if has("win32")
    autocmd BufEnter *.png,*.jpg,*gif exec "!start ".expand("%") | :bw
endif
if has("mac")
    autocmd BufEnter *.png,*.jpg,*gif exec "!open ".expand("%") | :bw
endif
"}}}
"}}}
"{{{ Graphical config
"{{{ Font and Colorscheme
set guifont=DroidSansMono_NF:h10:cANSI:qDRAFT
set t_Co=256
set background=dark
colorscheme slate
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
let g:airline_theme='cool'
"}}}
"{{{ UndoTree config
let g:undotree_WindowLayout = 3
"}}}
"{{{ Ale Config
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_lint_on_enter = 0
let g:ale_linters = {'python': ['pyflakes', 'flake8', 'pycodestyle'], 'vimscript': ['vint']}
let g:ale_echo_msg_error = 'E'
let g:ale_echo_msg_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"}}}
"{{{ Vimwiki Config
let wiki_1 = {}
let wiki_1.path = '~/vimwiki'
let wiki_1.index = 'index'
let wiki_2 = {}
let wiki_2.path = '~/Vimwiki'
let wiki_2.index = 'Main'
let g:vimwiki_list = [wiki_1, wiki_2]
"}}}
"}}}
"{{{ Keybindings
"{{{ Save file
nmap <F12> :w <CR>
"}}}
"{{{ Abbreviations
ca vsf vert sf
ca W w
ca Cd cd
ca Wq wq
"}}}
"{{{ Navigating split windows
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
"}}}
"{{{ Adjusting split windows
noremap <C-up> <C-w>+
noremap <C-down> <C-w>-
noremap <leader>] <C-w>>
noremap <leader>[ <C-w><
"}}}
"{{{ Navigating Tabs
" NOTE: gt is default
nnoremap gt :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>
"}}}
"{{{ Buffer management
nnoremap gb :ls<Cr>:b<Space>
"}}}
"{{{ NERDTree mapping
noremap <C-N> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
"}}}
"{{{ UNDOTree mapping
noremap <C-U> :UndotreeToggle<CR>
"}}}
"{{{ Textmanip mappings
let g:textmanip_enable_mappings = 1
xmap <Space>d <Plug>(textmanip-duplicate-down)
nmap <Space>d <Plug>(textmanip-duplicate-down)
xmap <Space>D <Plug>(textmanip-duplicate-up)
nmap <Space>D <Plug>(textmanip-duplicate-up)
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)
" Toggle insert/replace with <F10>
nmap <F9> <Plug>(textmanip-toggle-mode)
xmap <F9> <Plug>(textmanip-toggle-mode)
"}}}
" CTRLP Config{{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
"}}}
"{{{ Replace all is aliased to S
nnoremap S :%s//g<Left><Left>
"}}}
"{{{ Set Spell Options
nnoremap <F4> :setlocal spell! spelllang=en_us<cr>
"}}}
"}}}
"{{{ Vim airline config
set noshowmode
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"{{{ Unicode symbols depending on font
let g:airline_left_sep = '»'
let g:airline_left_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.notexists = ' '
let g:airline_symbols.whitespace = 'Ξ'
"}}}
" Powerline symbols if using powerline font{{{
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
"}}}
"}}}
" vim: ts=2 sts=2 sw=2 et
