set nocompatible

call plug#begin()

Plug 'joonty/vdebug'                    "debugging
Plug 'kshenoy/vim-signature'            "visible marks
Plug 'tpope/vim-surround'               "surround editing
Plug 'vimwiki/vimwiki'                  "Organisational stuff
Plug 'ctrlpvim/ctrlp.vim'               "Fuzzy finder
Plug 'Shougo/deoplete.nvim'             "completion

call plug#end()
call deoplete#enable()


filetype plugin indent on
syntax on


colorscheme ron

"Sane copy and paste
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

"Pressing enter in normal mode behaves like it would in insert mode
nnoremap <silent> <CR> i<CR><ESC>

"Toggle git blame statusbar
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit<CR>

noremap <Leader>vd :call VarDump()<CR>
nnoremap <Leader>x :OverCommandLine<CR>%s/

"Control t opens a new tab. Just like da interwebz
nmap <c-t> :tabnew<CR>

set tags=./tags;$HOME

"Commands
autocmd BufRead,BufNewFile *.json setfiletype javascript " Set all .json files to have JS syntax
autocmd BufRead,BufNewFile *.lock setfiletype javascript " Set all .lock files to have JS syntax

autocmd BufRead,BufNewFile *.less set filetype=less.css " Set all .less files to have CSS syntax
autocmd BufRead,BufNewFile *.scss set filetype=sass.css " Set all .scss files to have CSS syntax
autocmd FileType scss set iskeyword+=-

"Before we have written to our buffer, or when we read it,
"format it nicely on xml and html files
autocmd BufWritePre,BufRead *.html :normal gg=G
autocmd BufWritePre,BufRead *.xml :normal gg=G

" Makes sure our highlight doesn't get destroyed by setting the colorscheme
autocmd ColorScheme * highlight Search ctermfg=white ctermbg=green
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=yellow
autocmd ColorScheme * highlight overLengthSoft ctermbg=magenta
autocmd ColorScheme * highlight overLengthHard ctermbg=red

"Give our highlight groups names so we can display them on matches
highlight Search ctermfg=white ctermbg=green
highlight TrailingWhitespace ctermbg=yellow
highlight overLengthSoft ctermbg=magenta
highlight overLengthHard ctermbg=red

"Highlights
call matchadd('overLengthHard', '\%100v')
call matchadd('overLengthSoft', '\%81v')

scriptencoding utf-8 "Unicode support is good

set inccommand=split
set tabstop=4
set shiftwidth=4
set expandtab
set viminfo='20,<1000,s1000 "By default vim only yanks up to 50 lines. This changes it to 1000 lines
set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set foldmethod=manual "Apparently this should help autocomplete not be insanely slow
set backspace=indent,eol,start "Make backspace behave like it does everywhere else
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set complete-=i "Don't scan included files with omnicompletion
set relativenumber "Turn on relative numbering for all lines
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
set omnifunc=syntaxcomplete#Complete
set ruler "Show our current position
set number "Show line numbers
set mouse=a "mouse support
set shell=/bin/bash


"plugins

"vim-grepper
"Have a friendly remapping for :Grepper
nnoremap <Leader>z :Grepper -tool git -noswitch<CR>

"supertab
let g:SuperTabDefaultCompletionType = 'context'

"vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]

"commandT
let g:CommandTFileScanner = "git"

" Use thesilversearch instead of ack for greps
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Use matchit
if !exists('g:loaded_matchit')
    runtime macros/matchit.vim
endif
