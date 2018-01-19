call plug#begin()
    Plug 'ap/vim-css-color'
    Plug 'crusoexia/vim-monokai'
    Plug 'joereynolds/vim-minisnip'
    Plug 'joereynolds/deoplete-minisnip'
    Plug 'joereynolds/inspectee.vim'
    Plug 'joereynolds/SQHell.vim'
    Plug 'jsfaint/gen_tags.vim'
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'padawan-php/deoplete-padawan'
    Plug 'w0rp/ale'
    Plug 'machakann/vim-sandwich'

    "Messing around with Gonvim"
    Plug 'equalsraf/neovim-gui-shim'

call plug#end()

colorscheme monokai

silent! source ~/programs/configs/nvim/private.vim
silent! source ~/programs/configs/nvim/work.vim
silent! source ~/programs/configs/nvim/abbreviations.vim

"Clear the search when we press space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>

"Trying out gonvim
nnoremap ]w :GonvimWorkspaceNext<cr>
nnoremap [w :GonvimWorkspacePrevious<cr>
nnoremap ]m :GonvimMarkdown<cr>

"window resizing
nnoremap <up> :resize +10<cr>
nnoremap <down> :resize -10<cr>
nnoremap <left> :vertical resize -10<cr>
nnoremap <right> :vertical resize +10<cr>

"DIY autoclosing
inoremap (; ();<left><left>
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
set statusline=%{fugitive#statusline()}%y%m%=%f[%02p%%]
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

"Messing around with Gonvim
function! GV()
    Guifont Courier 10 Pitch:h11
    set laststatus=0
    set noruler 
    set noshowcmd
    set noshowmode
endfunction
