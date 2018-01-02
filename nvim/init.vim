call plug#begin()
    Plug 'ap/vim-css-color'
    Plug 'crusoexia/vim-monokai'
    Plug 'joereynolds/vim-minisnip'
    Plug 'joereynolds/SQHell.vim'
    Plug 'joereynolds/deoplete-minisnip'
    Plug 'joereynolds/place.vim'
    Plug 'jsfaint/gen_tags.vim'
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/vader.vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'padawan-php/deoplete-padawan'
    Plug 'w0rp/ale'
    Plug 'machakann/vim-sandwich'
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
inoremap ( ()<left>
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>

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

highlight WordUnder ctermfg = 3
highlight MatchParen ctermfg=7 ctermbg=3

command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set notimeout "Wait indefinitely for a keypress when we press the leader key
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%{fugitive#statusline()}%y%m%=%f[%02p%%][%{sqhell#Host()}]
set relativenumber "Turn on relative numbering for all lines
set tabstop=4 "Pressing tab should only indent 4 spaces
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set noswapfile "it's 2017, people!
set number "Show line numbers
set viminfo='100,<100000,s100000
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

"place.vim
nmap ga <Plug>(place-insert)
nmap gb <Plug>(place-insert-multiple)

"vim-minisnip
let g:minisnip_dir = '~/programs/configs/nvim/minisnip/'

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

" ]improved
" Inspectee
"
" What it does:
" Inspectee allows you to view the definition of what is under the cursor.
" It uses tags to find these definitions,
"
" There is a <Plug> mapping exposed, I recommend mapping this to [i
" to match the native behaviour (but better).
"
" When you press [i the definition will open up in a completion box
" above your cursor.
"
" How it works:
" It should insert the contents of `gd`. If no matches are found, it
" should look in the tags, finally as a last resort it should
" use cscope or global through the cscope interface.
"
" rambles:
"
" If no `gd` matches are found, try the tags.   
"   - Maybe use the results of `ts` unless there are better things to use?
" 
" TODO
"   - Split at @^ and insert each match in an array
"
inoremap <leader><leader> <c-r>=Inspectee()<cr>

"inspectee
function! Inspectee()
    redir @a
    try
        normal! [i 
    catch /E387/
        "]i found no matches so fallback to the superior tags file
        execute "silent! :tselect " . expand("<cword>")
    endtry
    redir end

    let completion_message = substitute(@a, "\n", "SPLIT_HERE", "g")
    let completion_items = split(completion_message, "SPLIT_HERE")

    call complete(col('.'), completion_items)
    return ''
endfunction
