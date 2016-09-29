
set nocompatible

call plug#begin()

"Dev
Plug 'adoy/vim-php-refactoring-toolbox' "refactoring tools
Plug 'ap/vim-css-color'                 "highlight css colours ... Doesn't seem to work :(
Plug 'ervandew/supertab'                "tab completion
Plug 'flazz/vim-colorschemes'           "colours
Plug 'hail2u/vim-css3-syntax'           "better syntax for css
Plug 'joonty/vdebug'                    "debugging
Plug 'kshenoy/vim-signature'            "visible marks
Plug 'qualiabyte/vim-colorstepper'      "switch colours no reload
Plug 'scrooloose/syntastic'             "linter
Plug 'tpope/vim-fugitive'               "git wrapper
Plug 'tpope/vim-surround'               "surround editing
Plug 'wincent/command-t'                "fuzzy file finder
Plug 'mhinz/vim-grepper'                "better grep

"Writing
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

call plug#end()

filetype plugin indent on
syntax on

"Learn vim properly. Disable lazyness
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>


"Sane copy and paste
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa


" ColorStepper Keys
nmap <F6> <Plug>ColorstepPrev
nmap <F7> <Plug>ColorstepNext

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

"Pressing enter in normal mode behaves like it would in insert mode
nnoremap <silent> <CR> i<CR><ESC>

"Toggle git blame statusbar
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gc :Gcommit<CR>


"Control t opens a new tab. Just like da interwebz
nmap <c-t> :tabnew<CR>

" ctrl l will append a semi-colon to the end of the line
nmap <c-l> A;<ESC>

set tags=./tags;$HOME

"Commands

autocmd BufWinEnter * setlocal modifiable

autocmd BufRead,BufNewFile *.json setfiletype javascript " Set all .json files to have JS syntax
autocmd BufRead,BufNewFile *.lock setfiletype javascript " Set all .lock files to have JS syntax

autocmd BufRead,BufNewFile *.less set filetype=less.css " Set all .less files to have CSS syntax
autocmd BufRead,BufNewFile *.scss set filetype=sass.css " Set all .scss files to have CSS syntax
autocmd FileType scss set iskeyword+=-

au VimEnter *.md colorscheme seoul256 "Different colorscheme when writing
au VimEnter *.md :Goyo "use goyo on md files.


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
match TrailingWhitespace /\s\+$/

scriptencoding utf-8 "Unicode support is good

set viminfo='20,<1000,s1000 "By default vim only yanks up to 50 lines. This changes it to 1000 lines
set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set foldmethod=manual "Apparently this should help autocomplete not be insanely slow
set backspace=indent,eol,start "Make backspace behave like it does everywhere else
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set complete-=i "Don't scan included files with omnicompletion
set relativenumber "Turn on relative numbering for all lines
set tabstop=4 "Pressing tab should only indent 4 spaces
set incsearch "highlight them as they're typed as well
set numberwidth=2 "Make the line number gutter smaller
set cursorline "Show the current line you're on
set encoding=utf-8 "We like funny characters
set ignorecase "Ignore cases when searching
set hlsearch "Highlight matching searches
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




"Not a fan of this hardcoded path...
source ~/programs/configs/vim/plugins.vim


" Use thesilversearch instead of ack for greps
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Use matchit
if !exists('g:loaded_matchit')
    runtime macros/matchit.vim
endif

colorscheme ron



"Runs the test your cursor is in
"Doesn't work
function! TestFunction()
    execute "normal! [m kk"
endfunction
