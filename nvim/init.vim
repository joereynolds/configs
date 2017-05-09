call plug#begin()

Plug 'ctrlpvim/ctrlp.vim'               "Fuzzy finder
Plug 'joonty/vdebug'                    "debugging
Plug 'kshenoy/vim-signature'            "visible marks
Plug 'mhinz/vim-grepper'                "better search
Plug 'neomake/neomake'                  "linting
Plug 'crusoexia/vim-monokai'            "nice colourscheme
Plug 'easymotion/vim-easymotion'        "it's pretty incredible
Plug 'Shougo/deoplete.nvim'             "completion
Plug 'tpope/vim-commentary'             "easier commenting
Plug 'tpope/vim-surround'               "surround editing
Plug 'vimwiki/vimwiki'                  "Organisational stuff
Plug 'godlygeek/csapprox'               "terminal colours


call plug#end()
call deoplete#enable()

colorscheme monokai

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

nnoremap <leader>e :e ~/programs/configs/nvim/init.vim<cr>
nnoremap <leader>f :Grepper -tool git -grepprg git grep -nIi<cr>

"IDE style mappings (Sublime text)
nmap <c-r> :CtrlPBufTag<cr>
nmap <c-t> :tabnew<cr>

"Error navigation
nmap <c-k>a :lopen<cr>
nmap <c-k>n :lnext<cr>
nmap <c-k>p :lprevious<cr>

"netrw
nnoremap <c-k>b :Lexplore<cr>
inoremap <c-k>b <esc>:Lexplore<cr>

"save like a sane person
nnoremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>

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

"Commands
autocmd BufRead,BufNewFile *.json setfiletype javascript " Set all .json files to have JS syntax
autocmd BufRead,BufNewFile *.lock setfiletype javascript " Set all .lock files to have JS syntax

autocmd BufRead,BufNewFile *.less set filetype=less.css " Set all .less files to have CSS syntax
autocmd BufRead,BufNewFile *.scss set filetype=sass.css " Set all .scss files to have CSS syntax

"Before we have written to our buffer, or when we read it,
"format it nicely on xml and html files
autocmd BufWritePre,BufRead *.html :normal gg=G
autocmd BufWritePre,BufRead *.xml :normal gg=G

autocmd BufEnter * :set modifiable
" Lint on write
autocmd! BufWritePost * Neomake


scriptencoding utf-8 "Unicode support is good

set viminfo='20,<1000,s1000 "By default vim only yanks up to 50 lines. This changes it to 1000 lines
set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set relativenumber "Turn on relative numbering for all lines
set inccommand=split "Live substitution is the bees knees
set tabstop=4 "Pressing tab should only indent 4 spaces
set numberwidth=2 "Make the line number gutter smaller
set cursorline "Show the current line you're on
set encoding=utf-8 "We like funny characters
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set number "Show line numbers
set mouse=a "mouse support
set shell=/bin/bash

"plugins

"netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = -40

"vim easymotion
"Have the motion work bi-directionally
nmap <leader><leader>w <Plug>(easymotion-bd-w)

"vim grepper
runtime autoload/grepper.vim
let g:grepper.dir = 'repo'
let g:grepper.highlight = 1
let g:grepper.simple_prompt = 1
let g:grepper.side = 1

"ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|git'
let g:ctrlp_match_window = 'top,order:ttb,results:30'
let g:ctrlp_max_depth = 100

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
