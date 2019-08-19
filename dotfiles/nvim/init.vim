call plug#begin()
    Plug 'joereynolds/gq.vim'
    Plug 'leafgarland/typescript-vim'
    Plug 'Lokaltog/vim-monotone'
    Plug 'machakann/vim-sandwich'
    Plug 'neoclide/coc.nvim', {'do': 'npm install'}
    Plug 'rhysd/git-messenger.vim'
    Plug 'simeji/winresizer'
    Plug 'srstevenson/vim-picker'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-projectionist'
    Plug 'w0rp/ale'
call plug#end()

silent! source ~/programs/configs/dotfiles/nvim/private.vim
source ~/programs/configs/dotfiles/nvim/abbreviations.vim

nmap [a <Plug>(ale_previous)
nmap ]a <Plug>(ale_next)
nmap ]r <Plug>(coc-references)
nmap ]d <Plug>(coc-definition)
nmap [o <Plug>(coc-codelens-action)
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap (; ();<left><left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ``` ```<cr>```<esc>O
tnoremap <esc> <c-\><c-n>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <silent> K :call CocAction('doHover')<cr>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>
nnoremap <c-p> :PickerEdit<cr>
nnoremap <leader>b :PickerBufferTag<cr>
nnoremap <leader>df :PickerTag<cr>

command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!

augroup init_vim
    autocmd!
    autocmd BufWritePost init.vim source %
    autocmd FileType php setlocal iskeyword+=$
    autocmd FileType markdown setlocal textwidth=80 spell
augroup END

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%y%m%=%f[%02p%%]
set inccommand=split "Live substitution is the bees knees
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set hidden
set noswapfile

let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0 "Ale makes vim shit itself on big files. Don't lint until we've done something
let g:ale_lint_on_insert_leave = 1
let g:ale_virtualtext_cursor = 1
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'PSR2'

"Performance improvements
set synmaxcol=200 "Don't bother highlighting anything over 200 chars
let loaded_matchparen = 1 "highlighting matching pairs is slow

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-case
endif

colorscheme monotone
