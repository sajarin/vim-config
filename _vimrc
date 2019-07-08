set nocompatible
syntax on
set encoding=utf8
filetype off
set hlsearch
set incsearch
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
    let ft = &ft " filetype
    silent exec ':e ' . $VIMRUNTIME . '\compilers.vim'| " file must be within vim runtime
    let lnum = search(ft)
    let line = getline(lnum)
    exec ':bd'| "exits the temp buffer
    exec line| "executes the final line
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
nnoremap <F11> :call VullScreen()<cr>
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
" Pomodoro
nnoremap <F10> :call PomodoroBreak()<cr>
nnoremap <F9> :call PomodoroStart()<cr>
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
fun! Beep() "beeps 3 times
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
fun! Beep() "beeps 3 times
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
"Pathogen
execute pathogen#infect()
filetype plugin indent on
"CUSTOMIZATION SECTION
" Set Font
set guifont=DroidSansMono_NF:h10:cANSI:qDRAFT
" Vintage colorscheme
colorscheme vintage
" Vim-airline & vintage theme
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='vintage'
"KEYBINDING SECTION
"Navigating split windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"Vim bufferline plugin for easily switching buffers
:noremap <C-left> :bprev<CR>
:noremap <C-right> :bnext<CR>
"Initiate Vim-airline symbols 
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
