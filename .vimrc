"Vim-Plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Townk/vim-autoclose'
Plug 'bling/vim-bufferline'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vimwiki/vimwiki'
" Plug 'jaxbot/browserlink.vim'
Plug 'mhinz/vim-startify'
call plug#end()
"{{{ Tabs, foldmethods, syntax
    set nocompatible
    set number
    set encoding=utf8
    set hlsearch
    set incsearch
    set laststatus=2
    set mouse=a
    set pastetoggle=<F2>
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set softtabstop=0
    set autoindent
    set foldmethod=marker
    :inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    :inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
      \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
    :inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
      \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
    nmap <F12> :w <CR>
    "}}} 
"{{{ Custom Functions  
" Template function
command Template :execute ':call Template("' . input("What filetype?: ") . '")' 
fun! Template(content)
    try
        silent execute ":r " . $VIMRUNTIME . '\' . a:content
        redraw!
    catch /.*/
        redraw
        echo "That template does not exist"
    endtry
endfun
" ToggleCursors
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
" Vullscreen 
:nnoremap <F11> :call VullScreen()<cr>
fun! VullScreen()
    if &go=~#'m'
        set go-=m
        set go-=T
        set go-=r
        set go-=l
    else
        set go+=m
        set go+=T
        set go+=r
        set go+=l
    endif
endfun
"}}}
"{{{ "Graphical config
" Set Font
set guifont=DroidSansMono_NF:h10:cANSI:qDRAFT
" colorschemes
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='cool'
set t_Co=256
set background=dark
colorscheme space_vim_theme
let g:materialmonokai_italic=1
let g:materialmonokai_subtle_spell=1
let g:undotree_WindowLayout = 3
let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_lint_on_enter = 0
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"}}}
"{{{ "Keybindings
"Navigating split windows
:noremap <C-J> <C-W><C-J>
:noremap <C-K> <C-W><C-K>
:noremap <C-L> <C-W><C-L>
:noremap <C-H> <C-W><C-H>
"Vim bufferline plugin for easily switching buffers
:noremap <C-left> :bprev<CR>
:noremap <C-right> :bnext<CR>
"NERDTree mapping
:noremap <C-N> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
"UNDOTree mapping
:noremap <C-U> :UndotreeToggle<CR>
"}}}
"{{{ "Vim airline config
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
   " Powerline symbols if using powerline font
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
