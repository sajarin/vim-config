    """""""""""""""""""""""""""""""""""""
    " Shaedil Dider Vimrc configuration " 
    """"""""""""""""""""""""""""""""""""" 
                set nocompatible
                syntax on
                set encoding=utf8
                filetype off

    """""""""""""""""""""""""""""""""""""
    "       Configuration Section       "
    """""""""""""""""""""""""""""""""""""
            " OSX backspace fix
                set backspace=indent,eol,start
            " Show linenumbers
                set number
            " Set Proper Tabs
                set tabstop=4
                set softtabstop=0
                set shiftwidth=4
                set expandtab
                set autoindent
            " Set number cursor
                set cursorline
            " Highlighting feature
                set hlsearch
                set incsearch
            " Change directory Automatically
                set autochdir
            " Paste mode Toggle
                set pastetoggle=<F2>
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
            " CompileAndRun() 
                map <F5> :call CompileAndRun()<CR>
                fun! CompileAndRun()
                    let extension = expand("%:e")| " E.g. '.py' or '.java'
                    let head = expand('%:r')| " just the filename without the extension
                    let ft = &ft 
                    silent exec ':e ' . $VIMRUNTIME . '\compilers.vim'| " NTS; '\compilers.vim' -> '\bundle\vim-<F5>-Run\plugin\compilers.vim'
                    let lnum = search(ft)
                    let line = getline(lnum)
                    exec ':bd'| "exits the temp buffer
                    exec line| "executes the final line
                endfun
            " Autocursorcolumn
                autocmd BufEnter * :call AutoSetCursorColumn()
                fun! AutoSetCursorColumn()
                    let numberOfLines = line('$')
                    if (numberOfLines > 20)
                        set cursorcolumn
                    else
                        set nocursorcolumn
                    endif
                endfun
            " Vullscreen - just regular terminal like vim
                nnoremap <F11> :call VullScreen()<cr>
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
    """""""""""""""""""""""""""""""""""""
    "          Plugins Section          "
    """""""""""""""""""""""""""""""""""""
            "These are the commands for pathogen
                execute pathogen#infect()
                filetype plugin indent on
            
            "Vimwiki
                filetype plugin on
                let wiki_1 = {}
                let wiki_1.path = 'C:\Users\User 3.Workstation-PC\vimwiki'
                let wiki_1.index = 'Main'
                let wiki_2 = {}
                let wiki_2.path = 'C:\Users\User 3.Workstation-PC\Desktop\Vim\music-wiki'
                let wiki_2.index = 'Index'
                let g:vimwiki_list = [wiki_1, wiki_2]

    """""""""""""""""""""""""""""""""""""
    "       Customization Section       "
    """""""""""""""""""""""""""""""""""""
            " Set Font
                set guifont=DroidSansMono_NF:h10:cANSI:qDRAFT
                let g:airline_powerline_fonts = 1
            " Vintage Theme
                colorscheme vintage
            " Vim-airline & vintage theme
                let g:airline#extensions#tabline#enabled = 1
                let g:airline#extensions#tabline#formatter = 'unique_tail'
                let g:airline_theme='vintage'
            " ALE sign errors
                let g:ale_sign_error = '●'
				let g:ale_sign_warning = '.'
                highlight ALEError guibg=#a45444
            " Vim-airline section config
                nnoremap <F10> :call PomodoroBreak()<cr>
                fun! PomodoroBreak()
                    let g:timer = timer_start(60000, 'Pomodoro', {'repeat':-1}) "12000 = 1 min 
                    let g:value = 0
                endfun
                fun! Pomodoro(timer)
                    let g:value +=1
                    if g:value == 5
                        call Beep()
                        echo 'break is over'
                    endif
                endfun
                fun! Beep()
                    " Beeps 3 times
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                endfun
                nnoremap <F9> :call PomodoroStart()<cr>
                fun! PomodoroStart()
                    let g:timer = timer_start(240000, 'Pomodoro', {'repeat':-1}) "12000 = 1 min 
                    let g:value = 0
                endfun
                fun! Pomodoro(timer)
                    let g:value +=1
                    if g:value == 5
                        call Beep()
                        echo 'take a break'
                    endif
                endfun
                fun! Beep()
                    " Beeps 3 times
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                    sleep 500m
                    exec ':exe "normal \<Esc>"'
                endfun
    """""""""""""""""""""""""""""""""""""
    "        Keybindings Section        "
    """""""""""""""""""""""""""""""""""""
            "For Splitting windows
                nnoremap <C-J> <C-W><C-J>
                nnoremap <C-K> <C-W><C-K>
                nnoremap <C-L> <C-W><C-L>
                nnoremap <C-H> <C-W><C-H>

            "Undotree
                nnoremap <C-u> :UndotreeToggle<cr>

            "This is for vim bufferline switch buffers using these keymaps
                :noremap <C-left> :bprev<CR>
                :noremap <C-right> :bnext<CR>
            
            "This is for vim-airline
                set noshowmode
                  if !exists('g:airline_symbols')
                    let g:airline_symbols = {}
                  endif
            "unicode symbols
                let g:airline_left_sep = '»'
                let g:airline_left_sep = ''
                let g:airline_right_sep = '«'
                let g:airline_right_sep = ''
                let g:airline_symbols.linenr = '☰'
                let g:airline_symbols.paste = 'ρ'
                let g:airline_symbols.paste = 'Þ'
                let g:airline_symbols.notexists = ' '
                let g:airline_symbols.whitespace = 'Ξ'
                
            " powerline symbols
                let g:airline_left_sep = ''
                let g:airline_left_alt_sep = ''
                let g:airline_right_sep = ''
                let g:airline_right_alt_sep = ''
                let g:airline_symbols.branch = ''
                let g:airline_symbols.readonly = ''
                let g:airline_symbols.linenr = '☰'
                let g:airline_symbols.maxlinenr = '' 
                
            "This is for Vim NERDTree
                map <C-n> :NERDTreeToggle<CR>
                let NERDTreeShowHidden=1
                let g:NERDTREEChDirMode=2
                let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '.class','\.sqlite$','__pycache__']
                let g:NERDTreeDirArrows=0
                let g:NERDTreeDirArrowExpandable = ''
                let g:NERDTreeDirArrowCollapsible = '▼'
				exec ':so $VIMRUNTIME\nerdtreehighlights.vim'| "Manually adding color to vimdevicons
                autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
				
                " NERDTress File highlighting
                let g:WebDevIcons_enable=1
                let g:WebDevIcons_enable_nerdtree=1
                let g:WebDevIcons_enable_airline_tabline=1
                let g:WebDevIcons_airline_statusline=1
                let g:WebDevIconsUnicodeGlyphDoubleWidth=1
                let g:WebDevIconsUnicodeDecorateFolderNodes=1
                let g:DevIconsEnableFoldersOpenClose=1
                let g:WebDevIcons_conceal_nerdtree_brackets=1
