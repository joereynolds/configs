call plug#begin()
    Plug 'ap/vim-css-color'
    Plug 'crusoexia/vim-monokai'
    Plug 'joereynolds/vim-minisnip'
    Plug 'joereynolds/deoplete-minisnip'
    Plug 'joereynolds/SQHell.vim'
    Plug 'jsfaint/gen_tags.vim'
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vader.vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-unimpaired'
    Plug 'padawan-php/deoplete-padawan'
    Plug 'w0rp/ale'
    Plug 'machakann/vim-sandwich'
    Plug 'xtal8/traces.vim'
call plug#end()

colorscheme monokai

silent! source ~/programs/configs/nvim/private.vim
silent! source ~/programs/configs/nvim/work.vim
silent! source ~/programs/configs/nvim/abbreviations.vim

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

"window resizing
nnoremap <up> :resize +10<cr>
nnoremap <down> :resize -10<cr>
nnoremap <left> :vertical resize -10<cr>
nnoremap <right> :vertical resize +10<cr>

"DIY autoclosing
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>

"misc
tnoremap <esc> <c-\><c-n>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>es :e ~/programs/configs/nvim/minisnip<cr>

augroup init_vim
    autocmd!
    autocmd BufWritePre,BufRead *.html :normal gg=G
    autocmd BufWritePost init.vim source %
    autocmd BufWritePost * :call TrimTrailingWhitespace()
    autocmd CursorMoved * exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

let stub = "xdg-open 'http://devdocs.io/?q="

command! -nargs=* DD silent! call system(stub . &ft . ' ' . expand('<cword>') . "'")
command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

highlight WordUnder ctermfg = 3

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%{fugitive#statusline()}%y%m%=%f[%02p%%]
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
let g:deoplete#enable_at_startup = 1
let g:gen_tags#ctags_auto_gen = 1
let g:gen_tags#gtags_auto_gen = 1

if has('nvim')
    set inccommand=split "Live substitution is the bees knees
endif

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-case
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

"fzf"
nnoremap <c-p> :GFiles<cr>
nnoremap <leader>b :BTags<cr>
nnoremap <leader>df :Tags<cr>
nnoremap <leader>t :tabnew<cr>

"File thing, unnamed
nnoremap <leader>fr :call RenameFile()<cr>
nnoremap <leader>fc :call CopyFile()<cr>

"SQHell
nnoremap <leader>se :SQHExecute<cr>
vnoremap <leader>se :SQHExecute<cr>
nnoremap <leader>sd :SQHShowDatabases<cr>

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
