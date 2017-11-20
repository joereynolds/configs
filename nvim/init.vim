call plug#begin()
    Plug 'airblade/vim-gitgutter'
    Plug 'ap/vim-css-color'
    Plug 'crusoexia/vim-monokai'
    Plug 'joereynolds/vim-minisnip'
    Plug 'joereynolds/deoplete-minisnip'
    Plug 'jsfaint/gen_tags.vim'
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    Plug 'Shougo/deoplete.nvim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-unimpaired'
    Plug 'padawan-php/deoplete-padawan'
    Plug 'w0rp/ale'
    Plug 'machakann/vim-sandwich'
    Plug 'xtal8/traces.vim'
call plug#end()

colorscheme monokai

silent! source ~/programs/configs/nvim/work.vim
silent! source ~/programs/configs/nvim/abbreviations.vim

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
nnoremap <m-=> <c-w>=

"semantic keybindings...kinda
nnoremap ]<cr> i<cr><esc>
nnoremap ]v :call ShowVariable()<cr>

function! ShowVariable()
    execute 'silent grep! .php.*\\b<cword> tags'
endfunction

"DIY autoclosing
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>

"misc
tnoremap <esc> <c-\><c-n>
nnoremap <leader>ev :e ~/programs/configs/nvim/init.vim<cr>
nnoremap <leader>es :e ~/programs/configs/nvim/snippets<cr>
vmap <C-c> "+yi
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

augroup init_vim
    autocmd!
    autocmd BufWritePre,BufRead *.html :normal gg=G
    autocmd BufWritePost init.vim source %
    autocmd BufWritePost * :call TrimTrailingWhitespace()
    autocmd CursorMoved * exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))
augroup END

let stub = "xdg-open 'http://devdocs.io/?q="

command! -nargs=* DD silent! call system(len(split(<q-args>, ' ')) == 0 ?
            \ stub . &ft . ' ' . expand('<cword>') . "'" : len(split(<q-args>, ' ')) == 1 ?
            \ stub . &ft . ' ' . <q-args> . "'" : stub . <q-args> . "'")

command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!

highlight WordUnder ctermfg = 3

function! DebugVariableUsage()
    highlight WordUnder ctermfg = 7 ctermbg = 1
endfunction

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%{fugitive#statusline()}%m%=%f[%02p%%]
set cscopetag "search both cscope's db AND the ctags tag file
set relativenumber "Turn on relative numbering for all lines
set tabstop=4 "Pressing tab should only indent 4 spaces
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set noswapfile "it's 2017, people!
set number "Show line numbers
set viminfo='100,<1000,s100
set mouse=a "mouse support
set hidden

let php_sql_query = 1
let php_htmlInStrings = 1
let g:ale_sign_column_always = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#enable_at_startup = 1
let g:gen_tags#ctags_auto_gen = 1
let g:gen_tags#gtags_auto_gen = 1
let g:matchparen_timeout = 10
let g:matchparen_insert_timeout = 10
let g:vdebug_options = {}
let g:vdebug_options["port"] = 1337
let g:vdebug_options["path_maps"] = {
    \ "/var/www/enterprise": "/home/joe/code/enterprise"
\}

if has('nvim')
    set inccommand=split "Live substitution is the bees knees
endif

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-case
    let g:gitgutter_grep_command = 'rg'
endif

"ctags/global
nnoremap <leader>csr :cs find c <cword><cr>
nnoremap <leader>css :cs find s <cword><cr>
nnoremap <leader>csd :cs find g <cword><cr>

"fugitive
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gd :Gvdiff<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gs :Gstatus<cr>

"leaderf
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_CursorBlink = 0
let g:Lf_DefaultMode = 'FullPath'
nnoremap <leader>b :LeaderfBufTag<cr>
nnoremap <leader>df :LeaderfTag<cr>

nnoremap <leader>t :tabnew<cr>
"File thing, unnamed
nnoremap <leader>fr :call RenameFile()<cr>
nnoremap <leader>fc :call CopyFile()<cr>

function! CopyFile()
    let new_name = input('[Copying File]New file: ', expand('%'), 'file')
    let original_file = expand('%')
    exec ':!cp ' . original_file . ' ' . new_name
    exec ':edit ' . new_name
    redraw!
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
