

set nocompatible

call plug#begin()

Plug 'Raimondi/delimitMate'             "auto-complete quotes etc...
Plug 'SirVer/ultisnips'                 "super duper snippets
Plug 'adoy/vim-php-refactoring-toolbox' "refactoring tools
Plug 'ap/vim-css-color'                 "highlight css colours ... Doesn't seem to work :(
Plug 'ervandew/supertab'                "tab completion
Plug 'flazz/vim-colorschemes'           "colours
Plug 'hail2u/vim-css3-syntax'           "better syntax for css
Plug 'joonty/vdebug'                    "debugging
Plug 'junegunn/goyo.vim'                "margins for writing
Plug 'kshenoy/vim-signature'            "visible marks
Plug 'mhinz/vim-grepper'                "better grep
Plug 'mhinz/vim-startify'
Plug 'scrooloose/syntastic'             "linter
Plug 'tpope/vim-fugitive'               "git wrapper
Plug 'tpope/vim-surround'               "surround editing
Plug 'vimwiki/vimwiki'                  "Organisational stuff
Plug 'wincent/command-t'                "fuzzy file finder

call plug#end()

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

"Control t opens a new tab. Just like da interwebz
nmap <c-t> :tabnew<CR>

"PHPStorm style mappings because I'm a convert and I am sorry vim people :(
nnoremap <c-j> :%s///g<left><left>

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
set spell spelllang=en_gb "british and proud m8
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

"vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]

"commandT
let g:CommandTFileScanner = "git"

"ultisnips
let g:UltiSnipsExpandTrigger = "<C-a>"
let g:UltiSnipsJumpForwardTrigger = "<C-d>"

" Use thesilversearch instead of ack for greps
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Use matchit
if !exists('g:loaded_matchit')
    runtime macros/matchit.vim
endif



"changesThis into-this
"useful for CSS refactoring
function CamelToDash()
    

endfunction

"Pressing <leader>vd will insert a var dump of the current variable you're on
"i.e.
"    $request = 5
"    <leader>vd
"    var_dump($request);
function VarDump()

endfunction
    

"=============
"|-INSPECTEE-|
"=============
noremap <F2> <C-R>=ShowPopup(expand("<cWORD>"))<CR>
inoremap <F2> <C-R>=ShowPopup(expand("<cWORD>"))<CR>

"debug
noremap <F3> :call GetVisualSelection()<CR>

function FindValueForVariable(variableName)
    "Remove crap characters like [{(,
    let stripped = substitute(a:variableName, '[', '', '')

    echoerr stripped
    "If it begins with self:: or static:: use gd
    if stridx(stripped, 'self') > -1 || stridx(stripped, 'static') > -1
        let match = execute "normal! gdfl=vaw"
        let variableValue = GetVisualSelection()
        echoerr variableValue
    endif
    "Otherwise use <C-]>
endfunction

"Grab the value from the define keyword
function FindFromDefine(variableName)
endfunction

function ShowPopup(variable)
    echoerr FindValueForVariable(a:variable)

    "Shows the popup menu with what you were trying to search for
    call complete(col('.'), ['Matches for ' . a:variable, a:variable, '.', '.'])
    return ''
endfunction

function GetVisualSelection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]

    echoerr join(lines, "\n")
    return join(lines, "\n")
endfunction




