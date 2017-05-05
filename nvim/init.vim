call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'               "Fuzzy finder
Plug 'joonty/vdebug'                    "debugging
Plug 'kshenoy/vim-signature'            "visible marks
Plug 'mhinz/vim-grepper'                "better search
Plug 'neomake/neomake'                  "linting
Plug 'sts10/vim-mustard'                "nice colourscheme
Plug 'Shougo/deoplete.nvim'             "completion
Plug 'tpope/vim-commentary'             "easier commenting
Plug 'tpope/vim-surround'               "surround editing
Plug 'vimwiki/vimwiki'                  "Organisational stuff
Plug 'godlygeek/csapprox'               "makes gvim colorschemes work in terminal vim

call plug#end()
call deoplete#enable()


filetype plugin indent on
syntax on

colorscheme mustard


"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

"Pressing enter in normal mode behaves like it would in insert mode
nnoremap <silent> <CR> i<CR><ESC>

nnoremap <leader>e :e ~/programs/configs/nvim/init.vim<cr>
nnoremap <leader>f :GrepperGit 

"IDE style mappings (Sublime text)
nmap <c-r> :CtrlPBufTag<cr>
nmap <c-t> :tabnew<cr>

"Error navigation
nmap <c-k>a :lopen<cr>
nmap <c-k>n :lnext<cr>
nmap <c-k>p :lprevious<cr>

"comments <c-_> actually means ctrl+/ for some reason _ is registered as /
nmap <c-_> gcc
vmap <c-_> gcc
imap <c-_> <esc>gcc 

nmap <c-g> :
imap <c-g> <esc>:

"copy paste
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa


set tags=./tags;$HOME

"Commands
autocmd BufRead,BufNewFile *.json setfiletype javascript " Set all .json files to have JS syntax
autocmd BufRead,BufNewFile *.lock setfiletype javascript " Set all .lock files to have JS syntax

autocmd BufRead,BufNewFile *.less set filetype=less.css " Set all .less files to have CSS syntax
autocmd BufRead,BufNewFile *.scss set filetype=sass.css " Set all .scss files to have CSS syntax

"Before we have written to our buffer, or when we read it,
"format it nicely on xml and html files
autocmd BufWritePre,BufRead *.html :normal gg=G
autocmd BufWritePre,BufRead *.xml :normal gg=G

" Lint on write
autocmd! BufWritePost * Neomake

scriptencoding utf-8 "Unicode support is good

set viminfo='20,<1000,s1000 "By default vim only yanks up to 50 lines. This changes it to 1000 lines
set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set backspace=indent,eol,start "Make backspace behave like it does everywhere else
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set relativenumber "Turn on relative numbering for all lines
set background=dark "We do this for the vim-mustard plugin
set inccommand=split "Live substitution is the bees knees
set tabstop=4 "Pressing tab should only indent 4 spaces
set numberwidth=2 "Make the line number gutter smaller
set spell spelllang=en_gb "british and proud m8
set cursorline "Show the current line you're on
set encoding=utf-8 "We like funny characters
set ignorecase "Ignore cases when searching
set hlsearch "Highlight matching searches
set incsearch "highlight them as they're typed as well
set wildmenu "Show completions in a bar
set expandtab "Change tabs into spaces
set ruler "Show our current position
set number "Show line numbers
set mouse=a "mouse support
set shell=/bin/bash


"plugins

"vim grepper
runtime autoload/grepper.vim
let g:grepper.dir = 'repo'


"ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|git'
let g:ctrlp_match_window = 'top,order:ttb,results:30'

"vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]

" Use thesilversearch instead for greps
if executable('ag')
    set grepprg=ag\ --nogroup
endif

" Use matchit
if !exists('g:loaded_matchit')
    runtime macros/matchit.vim
endif