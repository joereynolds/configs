call plug#begin()

Plug 'alvan/vim-php-manual',   {'for': ['php']}                             "php man pages
Plug 'crusoexia/vim-monokai'                                                "colourscheme
Plug 'google/vim-searchindex'                                               "shows search count
Plug 'janko-m/vim-test'                                                     "Run unit tests
Plug 'joereynolds/fzf-makefile'                                             "Fuzzy makefile
Plug 'joereynolds/gtags-scope'                                              "cscope, but better
Plug 'joereynolds/vim-minisnip'                                             "snippets
Plug 'joonty/vdebug'                                                        "Debugging support
Plug 'jsfaint/gen_tags.vim'                                                 "autogen gtags
Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' } "Fuzzy searching
Plug 'junegunn/fzf.vim'                                                     "Fuzzy searching
Plug 'kshenoy/vim-signature'                                                "visible marks
Plug 'mhinz/vim-randomtag'                                                  "Learn docs
Plug 'mxw/vim-jsx',            {'for': ['javascript', 'javascript.jsx']}    "react
Plug 'ozelentok/deoplete-gtags'                                             "gtag deoplete
Plug 'Shougo/deoplete.nvim'                                                 "completion
Plug 'tpope/vim-commentary'                                                 "easier commenting
Plug 'tpope/vim-fugitive'                                                   "git integration
Plug 'tpope/vim-surround'                                                   "surround editing
Plug 'Valloric/MatchTagAlways'                                              "highlight end tag
Plug 'w0rp/ale'                                                             "linting
Plug 'wlangstroth/vim-racket', {'for': ['scheme', 'racket']}                "racket support

call plug#end()

colorscheme monokai

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

"resize windows easily
nnoremap <up> :resize +10<cr>
nnoremap <down> :resize -10<cr>
nnoremap <left> :vertical resize -10<cr>
nnoremap <right> :vertical resize +10<cr>

nnoremap [l :lprev<cr>
nnoremap ]l :lnext<cr>

"move code up or down
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

"'Auto closing'
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>

tnoremap <esc> <c-\><c-n>

"IDE style mappings (Sublime text)
nmap <c-t> :tabnew<cr>

"save like a sane person		
nnoremap <c-s> :w<cr>		
inoremap <c-s> <esc>:w<cr>		

"copy paste
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

augroup set_syntax
    autocmd!
    autocmd BufRead,BufNewFile *.json setfiletype javascript
    autocmd BufRead,BufNewFile *.lock setfiletype javascript
    autocmd BufRead,BufNewFile *.less set filetype=less.css
    autocmd BufRead,BufNewFile *.scss set filetype=sass.css
augroup END

augroup formatting
    autocmd!
    autocmd BufWritePre,BufRead *.html :normal gg=G
    autocmd BufWritePre,BufRead *.xml :normal gg=G
augroup END

augroup sourcing
    autocmd!
    autocmd BufWritePost init.vim source %
augroup END

augroup indentation
    autocmd FileType css setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

augroup on_enter
    autocmd BufEnter * :set modifiable
    autocmd VimEnter * :Random
augroup END

highlight WordUnder ctermfg = 13
autocmd CursorMoved * exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))

scriptencoding utf-8 "Unicode support is good

"statusline
set statusline=%{fugitive#statusline()}%m%=%f[%02p%%,04l,%03v]
hi StatusLine ctermbg=black ctermfg=white

set viminfo='20,<1000,s1000 "By default vim only yanks up to 50 lines. This changes it to 1000 lines
set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set cscopetag "search both cscope's db AND the ctags tag file
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

"ale
let g:ale_sign_column_always = 1

"gtags-scope
"Find all [r]eferences to this function
nnoremap <leader>csr :cs find c <cword><cr>
"Find all references to constants and other stuff
nnoremap <leader>css :cs find s <cword><cr>
"Find the definition of the word
nnoremap <leader>csd :cs find g <cword><cr>

let g:GtagsCscope_Quiet = 1
let g:GtagsCscope_Auto_Load = 1

"deoplete
let g:deoplete#enable_at_startup = 1

"fugitive
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gvdiff<cr>
"For some reason :Gpush crashes my terminal so have to use the native version
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gt :Git stash<cr>
nnoremap <silent> <leader>gh :call fzf#run({'source': "git branch \| cut -c 3-", 'sink': 'silent !git checkout'})<cr>

"fzf
nnoremap <c-p> :GFiles<cr>
nnoremap <leader>b :BTags<cr>
nnoremap <leader>z :Ag<cr>

"jsfaint
let g:gen_tags#ctags_auto_gen = 1
let g:gen_tags#gtags_auto_gen = 1

"vim-test
nnoremap <leader>t :TestFile -strategy=neovim<cr>

"vdebug
let g:vdebug_options = {}
let g:vdebug_options["port"] = 1337

let g:vdebug_options["path_maps"] = {
\ "/var/www/enterprise": "/home/joe/code/enterprise"
\}

"netrw
let g:netrw_liststyle = 3 "style it as a tree
let g:netrw_preview = 1   "open file previews vertically
let g:netrw_banner = 0    "Hide the default banner
let g:netrw_winsize = -40 "Give the window an absolute size of 40

"File thing, unnamed
nnoremap <leader>fr :call RenameFile()<cr>
nnoremap <leader>fc :call CopyFile()<cr>
nnoremap <leader>fn :call CreateFile()<cr>

"Various others
" nnoremap <leader>x :RemoveOnSameLine
nnoremap <leader>ev :e ~/programs/configs/nvim/init.vim<cr>
nnoremap <leader>es :e ~/programs/configs/nvim/snippets<cr>
"show snippets (Need to figure out the sink to just insert the text)
nnoremap <silent> <leader>s :call fzf#run({'source': "ls ~/programs/configs/nvim/snippets", 'sink': 'insert'})<cr>
nnoremap <silent> <leader>m :call makefile#CompleteMakefile()<cr>

if executable('ag')
    set grepprg=ag\ --nogroup
endif

"vim-jsx
let g:jsx_ext_required = 0

"match tag always
let g:mta_filetypes = {
   \'html': 1,
   \'xml': 1,
   \'php': 1,
   \'xhtml': 1,
   \}

" Use matchit
if !exists('g:loaded_matchit')
    runtime macros/matchit.vim
endif

function! CopyFile()
    let new_name = input('[Copying File]New file: ', expand('%'), 'file')
    let original_file = expand('%')
    exec ':!cp ' . original_file . ' ' . new_name
    exec ':edit ' . new_name
    redraw!
endfunction

function! CreateFile()
    let new_name = input('[Creating File]New file: ', expand('%'), 'file')
    if new_name != ''
        exec ':edit ' . new_name
        redraw!
    endif
endfunction

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('[Renaming File]New file: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

function! DeleteFile()
endfunction

function! MoveVisualSelectionToNewFile()
    let file_name = input('New file: ', expand('%'), 'file')
    exec ':normal! gvd'
    exec ':w!'
    exec 'vsp: ' . file_name
    exec ':w!'
endfunction
