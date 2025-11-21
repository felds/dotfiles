syntax on

" Hide the current buffer when opening another one
" (e.g. when calling :Explore, :new, or using CtrlP)
set hidden

" Syntax highlight
syntax on

" Show status bar under the document
set ruler

" " Show invisibles
" set list

" Use filetype plugin
filetype plugin on
" Filetype associations
au BufRead,BufNewFile *.less set filetype=less
au BufRead,BufNewFile *.twig set filetype=jinja
au BufRead,BufNewFile *.es6 set filetype=javascript

" Highlighted search results
set hlsearch
" Use incremental searching
set incsearch


" Allow files to define formatting in the first line
set modeline
set modelines=5

" force expandtab as default
set expandtab

" Don't let VIM try to fix the case when auto-completing
set infercase!

" Linewidth to infinite and beyond
set textwidth=0

" Do not wrap lines automatically
set nowrap

" Show line numbers by default
set number relativenumber

" Jump 5 lines when running out of the screen
set scrolljump=5

" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=5

" Map <CTRL>-B to run PHP parser check
noremap <C-B> :!php -l %<CR>

" Case insensitive search
set ignorecase

" Turn off audible bell
set visualbell

" Do not hide dotfiles (prevent vim-sensible from hiding them)
let g:netrw_list_hide = '\~$,^tags$,.sw[op]$,.netrwhist,.DS_Store'

" Use a single folder for all VIM temp files
" (it doesn't let VIM pollute the working dir)
let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
if isdirectory(expand(s:dir))
    if &directory =~# '^\.,'
        let &directory = expand(s:dir) . '/swap//,' . &directory
    endif
    if &backupdir =~# '^\.,'
        let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
    endif
    if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
        let &undodir = expand(s:dir) . '/undo//,' . &undodir
    endif
endif
if exists('+undofile')
    set undofile
endif

"----------------------"
"- START Nginx syntax -"
"----------------------"

au BufRead,BufNewFile /etc/nginx/*,/usr/local/nginx/conf/* if &ft == '' | setfiletype nginx | endif 

"--------------------"
"- END Nginx syntax -"
"--------------------"
