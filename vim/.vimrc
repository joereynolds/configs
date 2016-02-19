set nocompatible
execute pathogen#infect()
call pathogen#helptags()

filetype plugin indent on

"Keyboard mappings
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap < <><Left>

"Learn vim properly. Disable lazyness
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

" runs the current file you're in
map <buffer> <F5> :w<CR>:!php %<CR>

" times scripts execution
map <buffer> <S-F5> :w<CR>:!time php %<CR>

"Toggle the tagbar when we press f4
map <F4> :TagbarToggle<CR>

"Control t opens a new tab. Just like da interwebz
nmap <c-t> :tabnew<CR>

"Go to next tab with tab
nmap <Tab> :tabnext<CR>

"Go to next match from vimgrep with right arrow"
nmap <Right> :cnext<CR>

"Go to next match from vimgrep with right arrow"
nmap <Left> :cprev<CR>

set tags=tags;/

"Commands

"On startup, turn the tagbar on
autocmd VimEnter *.php TagbarToggle

" Makes sure our highlight doesn't get destroyed by setting the colorscheme
autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=red

"When we write to the buffer, run pylint on the current file
"if it's a python file
autocmd BufWritePost *.py !pylint <afile>

"Before we have written to our buffer, or when we read it,
"format it nicely on xml and html files
autocmd BufWritePre,BufRead *.xml :normal gg=G
autocmd BufWritePre,BufRead *.html :normal gg=G

au BufRead,BufNewFile *.less setfiletype css " Set all .less files to have CSS syntax
au BufRead,BufNewFile *.scss setfiletype css " Set all .scss files to have CSS syntax
au BufRead,BufNewFile *.json setfiletype javascript " Set all .json files to have JSON syntax
au BufRead,BufNewFile *.lock setfiletype javascript " Set all .lock files to have JSON syntax

highlight TrailingWhitespace ctermbg=red "Give our highlight group a name so we can display it on matches

"Highlights
match TrailingWhitespace /\s\+$/

"Skeletons
"none here yet....

scriptencoding utf-8 "Unicode support is good

set number "Show line numbers
set ruler "Show our current position
set omnifunc=syntaxcomplete#Complete
set expandtab "Change tabs into spaces
set hlsearch "Highlight matching searches
set ignorecase "Ignore cases when searching
set encoding=utf-8 "We like funny characters
set cursorline "Show the current line you're on
set numberwidth=2 "Make the line number gutter smaller
set incsearch "highlight them as they're typed as well
set tabstop=4 "Pressing tab should only indent 4 spaces
set relativenumber "Turn on relative numbering for all lines
set complete-=i "Don't scan included files with omnicompletion
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set backspace=indent,eol,start "Make backspace behave like it does everywhere else
set scrolloff=3 "Keep at least 3 lines in view when the cursor hits the bottom of the buffer
set viminfo='20,<1000,s1000 "By default vim only yanks up to 50 lines. This changes it to 1000 lines


"syntastic plugin settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*o

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

syntax on
colorscheme elflord
