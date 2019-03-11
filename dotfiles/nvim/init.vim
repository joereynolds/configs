call plug#begin()
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'Lokaltog/vim-monotone'
    Plug 'machakann/vim-sandwich'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-projectionist'
    Plug 'w0rp/ale'
    Plug 'simeji/winresizer'
    Plug 'neoclide/coc.nvim', {'do': 'npm install'}
    Plug 'leafgarland/typescript-vim'
call plug#end()

silent! source ~/programs/configs/dotfiles/nvim/private.vim
source ~/programs/configs/dotfiles/nvim/abbreviations.vim

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

nmap [a <Plug>(ale_previous)
nmap ]a <Plug>(ale_next)
nmap ]r <Plug>(coc-references)
nmap ]d <Plug>(coc-definition)
nmap [o <Plug>(coc-codelens-action)
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>

"DIY autoclosing
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ``` ```<cr>```<esc>O
inoremap --- ---<cr>---<esc>O

"misc
tnoremap <esc> <c-\><c-n>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> K :call CocAction('doHover')<cr>

augroup init_vim
    autocmd!
    autocmd BufWritePost init.vim source %
    autocmd FileType php setlocal iskeyword+=$
    autocmd FileType markdown setlocal textwidth=80 spell
augroup END

command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%y%m%=%f[%02p%%]
set inccommand=split "Live substitution is the bees knees
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set mouse=a "mouse support
set hidden

let g:ale_lint_on_insert_leave = 1
let g:ale_virtualtext_cursor = 1
let g:ale_fixers = {
            \'*': ['remove_trailing_lines', 'trim_whitespace'],
            \'html': ['tidy'],
            \'php': ['php_cs_fixer'], 
            \'python': ['autopep8'],
            \'typescript': ['prettier'],
            \}
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = "PSR2"

"Performance improvements
set synmaxcol=200 "Don't bother highlighting anything over 200 chars
let loaded_matchparen = 1 "highlighting matching pairs is slow

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-case
endif

if !executable('fd')
    echoerr "fzf relies on fd to be installed, install it."
endif

"fzf
nnoremap <c-p> :GFiles<cr>
nnoremap <leader>b :BTags<cr>
nnoremap <leader>df :Tags<cr>

colorscheme monotone
