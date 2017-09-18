call plug#begin()
    Plug 'alvan/vim-php-manual',   {'for': ['php']}                             "php man pages
    Plug 'ap/vim-css-color'
    Plug 'carlitux/deoplete-ternjs'                                             "js completion
    Plug 'crusoexia/vim-monokai'                                                "colourscheme
    Plug 'joereynolds/gtags-scope'                                              "cscope, but better
    Plug 'joereynolds/vim-minisnip'                                             "snippets
    " Plug 'joereynolds/deoplete-minisnip'
    " Plug 'joonty/vdebug'                                                        "Debugging support
    Plug 'jsfaint/gen_tags.vim'                                                 "autogen gtags
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' } "Fuzzy searching
    Plug 'junegunn/fzf.vim'                                                     "Fuzzy searching
    Plug 'kassio/neoterm'                                                       "Send commands to a terminal
    Plug 'mhinz/vim-randomtag'                                                  "Learn docs
    Plug 'ozelentok/deoplete-gtags'                                             "gtag deoplete
    Plug 'Shougo/deoplete.nvim'                                                 "completion
    Plug 'tpope/vim-commentary'                                                 "easier commenting
    Plug 'tpope/vim-fugitive'                                                   "git integration
    Plug 'tpope/vim-surround'                                                   "surround editing
    Plug 'padawan-php/deoplete-padawan'                                         "php completion
    Plug 'w0rp/ale'                                                             "linting
call plug#end()

colorscheme monokai

source ~/programs/configs/nvim/work.vim
source ~/programs/configs/nvim/abbreviations.vim

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

"window resizing
nnoremap <up> :resize +10<cr>
nnoremap <down> :resize -10<cr>
nnoremap <left> :vertical resize -10<cr>
nnoremap <right> :vertical resize +10<cr>

"wrist friendly
nnoremap <m-h> <c-w>h
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-l> <c-w>l
nnoremap <m-v> <c-w>v
nnoremap <m-=> <c-w>=

"semantic keybindings...kinda
nnoremap [l :lprev<cr>
nnoremap ]l :lnext<cr>
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap ]<cr> i<cr><esc>
nnoremap ]v :execute 'silent grep! .php.*\\b<cword> tags'<cr>

"move codeblocks
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

"DIY autoclosing
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>

"misc
tnoremap <esc> <c-\><c-n>
nnoremap <c-t> :tabnew<cr>
nnoremap <leader>ev :e ~/programs/configs/nvim/init.vim<cr>
nnoremap <leader>es :e ~/programs/configs/nvim/snippets<cr>
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

augroup init_vim
    autocmd!
    autocmd BufRead,BufNewFile *.vim set filetype=vim
    autocmd BufWritePre,BufRead *.html :normal gg=G
    autocmd BufWritePre,BufRead *.xml :normal gg=G
    autocmd BufWritePost init.vim source %
    autocmd BufWritePost * :call TrimTrailingWhitespace()
    autocmd CursorMoved * exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))
augroup END

command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!

let php_sql_query = 1
let php_htmlInStrings = 1

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%{fugitive#statusline()}%m%=%f[%02p%%,04l,%03v]
set cscopetag "search both cscope's db AND the ctags tag file
set relativenumber "Turn on relative numbering for all lines
set inccommand=split "Live substitution is the bees knees
set tabstop=4 "Pressing tab should only indent 4 spaces
set lazyredraw "refresh the screen less often
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set number "Show line numbers
set mouse=a "mouse support

highlight StatusLine ctermbg=black ctermfg=Gray
highlight WordUnder ctermfg = 13

if executable('rg')
    set grepprg=rg\ --vimgrep
endif

let g:ale_sign_column_always = 1
let g:deoplete#enable_at_startup = 1
let g:gen_tags#ctags_auto_gen = 1
let g:gen_tags#gtags_auto_gen = 1
let g:GtagsCscope_Quiet = 1
let g:GtagsCscope_Auto_Load = 1
let g:neoterm_autoscroll = 1
let g:neoterm_size = 10
let g:neoterm_fixedsize = 1
let g:netrw_liststyle = 3 "style it as a tree
let g:netrw_preview = 1   "open file previews vertically
let g:netrw_banner = 0    "Hide the default banner
let g:netrw_winsize = -40 "Give the window an absolute size of 40
let g:vdebug_options = {}
let g:vdebug_options["port"] = 1337
let g:vdebug_options["path_maps"] = {
    \ "/var/www/enterprise": "/home/joe/code/enterprise"
\}

"ctags/global
nnoremap <leader>csr :cs find c <cword><cr>
nnoremap <leader>css :cs find s <cword><cr>
nnoremap <leader>csd :cs find g <cword><cr>

"fugitive
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gl :silent Glog<cr>:cw<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gd :Gvdiff<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gt :Git stash<cr>
nnoremap <silent> <leader>gh :call fzf#run({'source': "git branch -a --set-upstream \| cut -c 3- \| sed 's#^remotes/[^/]*/##'", 'sink': 'silent !git checkout'})<cr>

"fzf
nnoremap <c-p> :GFiles<cr>
nnoremap <leader>b :BTags<cr>
nnoremap <leader>z :Ag<cr>

"File thing, unnamed
nnoremap <leader>fr :call RenameFile()<cr>
nnoremap <leader>fc :call CopyFile()<cr>
nnoremap <leader>fn :call CreateFile()<cr>

"Ternjs
let g:deoplete#sources#ternjs#docs = 1

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

function! TrimTrailingWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfunction
