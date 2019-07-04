"""""""""""""""
""" General """
"""""""""""""""

" Set history
set history=500

" Use filetype-specific indent files
filetype plugin on
filetype indent on

" Auto-reload files when they are externally changed
set autoread

" :W sudo saves the file
command W w !sudo tee & > /dev/null

""""""""""
""" UI """
""""""""""

" Visual autocomplete for command menu
set wildmenu

" Exclude common stuff from search results
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Show current position
set ruler

" Show command in bottom bar
set showcmd

" 2 line command bar
set cmdheight=2

" Show line numbers
set number

" A buffer becomes hidden when it is abandoned
set hid

" Make backspace work right
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" Be smart about search casing
set smartcase

"Incrementally highlight search results
set incsearch
set hlsearch

" Redraw only when needed
set lazyredraw

" Enable magic for regexes
set magic

" Show matching parentheses and blink for 2/10 of a second
set showmatch
set mat=2

" No annoying sounds on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add an extra column of left margin
set foldcolumn=1

""""""""""""""""""""""
""" Colors & Fonts """
""""""""""""""""""""""

" Enable syntax processing
syntax enable

" Enable 256 color palette in GNOME
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set dark background
set background=dark

" Set some GUI-specific options
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Use UTF8 by default
set encoding=utf8

"Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""
""" Files & Backups """
"""""""""""""""""""""""

" Disable all the .swp file stuff because we're using version control anyway
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""
""" Tabbing & indentation """
"""""""""""""""""""""""""""""

" 4 tab spaces, prefer spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Enable smart tab functionality
set smarttab

" Auto-indent
set ai

" Smart-indent
set si

"""""""""""""""""""
""" Status Line """
"""""""""""""""""""

" Always show status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

""""""""""""""""
""" Movement """
""""""""""""""""

" Search with space and reverse search with C-space
map <space> /
map <c-space> ?

" Move between windows with C-(movekeys)
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""
""" Editing """
"""""""""""""""

" Trim trailing whitespace on save
autocmd BufWritePre * :call TrimWhiteSpace()

"""""""""""""""
""" Plugins """
"""""""""""""""

" Enable Pathogen
execute pathogen#infect()

" Enable CtrlP
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Open NERDTree automatically on start
autocmd vimenter * NERDTree

" Close VIM when the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Change NERDTree default arrows
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Show dotfiles in NERDTree
let NERDTreeShowHidden=1

""""""""""""""""""""""""
""" Helper Functions """
""""""""""""""""""""""""

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

function! TrimWhiteSpace()
    let saved_view = winsaveview()
    keepjumps '[,']s/\s\+$//e
    call winrestview(saved_view)
endfunction

