call plug#begin()
    Plug 'machakann/vim-sandwich'
    Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
    Plug 'srstevenson/vim-picker'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'w0rp/ale'
    Plug 'tmsvg/pear-tree'
call plug#end()

source ~/private.vim
command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
packadd cfilter

nmap ]b :bnext<cr>
nmap [b :bprevious<cr>
nmap [a <Plug>(ale_previous)
nmap ]a <Plug>(ale_next)
nmap ]r <Plug>(coc-references)
nmap ]d <Plug>(coc-definition)
nmap <c-p> <Plug>(PickerEdit)
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
inoremap ``` ```<cr>```<esc>O
inoremap ; <esc>mzA;<esc>`z
tnoremap <esc> <c-\><c-n>
nnoremap <silent> K :call CocAction('doHover')<cr>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

set expandtab "Change tabs into spaces
set grepprg=rg\ --vimgrep\ --ignore-case
set ignorecase "Ignore cases when searching
set inccommand=split "Live substitution is the bees knees
set noswapfile
set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%y%m%=%f\ [%02p%%]\ [%L]
let loaded_matchparen = 1 "Crazy slow and annoying highlighting
let loaded_netrwPlugin = 1 " https://github.com/vim/vim/issues/5073
let g:ale_virtualtext_cursor = 1
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'psr2'

call coc#add_extension('coc-json', 'coc-git', 'coc-phpls', 'coc-css', 'coc-html', 'coc-tslint', 'coc-tsserver', 'coc-snippets')

augroup init_vim
    autocmd!
    autocmd BufWritePost init.vim source %
augroup END

colorscheme monotone
