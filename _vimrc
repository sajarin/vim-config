" This is my vimrc. There are many like it, but this one is mine.
"
" Maintainer:	Sajarin Dider <sajarindider@gmail.com>
" Last change:	2022 Nov 6
" ===================================================================
"{{{ Plugins
    call plug#begin('~/Dropbox/vim/plugged')
    if has("gui_running")
        Plug 'Nequo/vim-allomancer'
    endif
    Plug 'junegunn/vim-plug'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'skywind3000/vim-bgimg'
    Plug 'https://github.com/ctrlpvim/ctrlp.vim'
    Plug 'w0rp/ale'
    Plug 'machakann/vim-highlightedyank'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
    call plug#end()
"}}}
"{{{ General  
    filetype plugin on
    set nocompatible
    set number
    set encoding=utf8
    set pastetoggle=<F2>
    set tabstop=4        "tab is equal to 4 spaces
    set softtabstop=4    "tab when inserting is 4 spaces
    set expandtab        "tabs are spaces
    set showcmd
    set autoindent
    set shiftwidth=4
    set foldmethod=marker
    set tags=tags
    set wildmenu         "visual autocomplete for command menu 
    set showmatch        "highlight matching brackets, curly braces and parenthesis
    set incsearch        "search as characters are entered
    set hlsearch         "highlight matches
    nmap <F12> :w <CR>
    :set directory^=~/Dropbox/vim/swapfiles/  " Aggregate all vim swap files to a one place
"}}}
" Folding {{{
    set foldenable       "enable folding
    set foldlevelstart=10 "open most folds by default
    set foldnestmax=10   "10 nested fold max
    set foldmethod=marker 
    set foldlevel=0
" }}}
"{{{ Graphics 
    " Colorscheme & Background {{{
        set background=dark
        set termguicolors
        if has ("gui_running")
            :call bgimg#set_bg(0x002b36)
            :call bgimg#set_image('C:\Users\Sajarin\Dropbox\vim\mage1.bmp')
            colo allomancer 
        endif
    "}}}
    "{{{ Airline Config
        let g:airline_powerline_fonts = 0
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:airline_theme = 'transparent'

        "{{{ Symbols
            set noshowmode
              if !exists('g:airline_symbols')
                let g:airline_symbols = {}
              endif

              " unicode symbols
              let g:airline_left_sep = '|'
              let g:airline_left_sep = '|'
              let g:airline_right_sep = '|'
              let g:airline_right_sep = '|'
              let g:airline_symbols.crypt = '🔒'
              let g:airline_symbols.linenr = '☰'
              let g:airline_symbols.linenr = ''
              let g:airline_symbols.linenr = ''
              let g:airline_symbols.linenr = '¶'
              let g:airline_symbols.maxlinenr = ''
              let g:airline_symbols.maxlinenr = '㏑'
              let g:airline_symbols.branch = ''
              let g:airline_symbols.paste = 'ρ'
              let g:airline_symbols.paste = 'Þ'
              let g:airline_symbols.paste = '∥'
              let g:airline_symbols.spell = 'Ꞩ'
              let g:airline_symbols.notexists = ''
              let g:airline_symbols.whitespace = 'Ξ'

              " powerline symbols
              let g:airline_left_sep = ''
              let g:airline_left_alt_sep = ''
              let g:airline_right_sep = ''
              let g:airline_right_alt_sep = ''
              let g:airline_symbols.branch = ''
              let g:airline_symbols.readonly = ''
              let g:airline_symbols.linenr = ''
              let g:airline_symbols.maxlinenr = ''
              let g:airline_symbols.dirty='⚡'
        "}}}
    "}}}
"}}}
"{{{ Vimwiki
    let main = {}
    let g:vimwikidir = $HOME . "/Dropbox/vimwiki/main"
    let main.path = g:vimwikidir

    let meetings = {}
    let meetings.path = $HOME . "/Dropbox/vimwiki/meetings"

    let books = {}
    let books.path = $HOME ."/Dropbox/vimwiki/books"
    let g:vimwiki_list=[main, meetings, books]

"}}}
"{{{ Ale Config
    let g:ale_sign_error = '✗'
    let g:ale_sign_warning = '⚠'
    let g:ale_lint_on_enter = 0
    let g:ale_fix_on_save = 0
    let g:ale_linters = {'python': ['pyflakes', 'flake8', 'pycodestyle', 'pylint']}
    let g:ale_echo_msg_error = 'E'
    let g:ale_echo_msg_warning = 'W'
    let g:ale_echo_msg_format = '[%linter%] %code%: %s'
    highlight ALEErrorSign ctermbg=NONE ctermfg=red
    highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"}}}
"{{{ Keybindings
"}}}
"{{{ Custom Functions  
    " Vullscreen {{{
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
        nnoremap <F4> :setlocal spell! spelllang=en_us<cr>
        function! GetRangeForQuestionCount() range
           exec ":".a:firstline.",".a:lastline.'s/^[^= -*-]//n'
        endfunction
        command! -range=% QuestionCount <line1>,<line2>call GetRangeForQuestionCount()
    "}}}
"}}}
