call plug#begin()
    Plug 'Lokaltog/vim-monotone'
    Plug 'machakann/vim-sandwich'
    Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
    Plug 'simeji/winresizer'
    Plug 'srstevenson/vim-picker'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-projectionist'
    Plug 'w0rp/ale'
call plug#end()

source ~/code/me/configs/roles/common/files/nvim/abbreviations.vim
command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
packadd cfilter

nmap [a <Plug>(ale_previous)
nmap ]a <Plug>(ale_next)
nmap ]r <Plug>(coc-references)
nmap ]d <Plug>(coc-definition)
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap ( ()<left>
inoremap [ []<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ; <esc>mzA;<esc>`z
inoremap ``` ```<cr>```<esc>O
tnoremap <esc> <c-\><c-n>
nnoremap <silent> K :call CocAction('doHover')<cr>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>
nnoremap <c-p> :PickerEdit<cr>

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%y%m%=%f\ [%02p%%]\ [%L]
set inccommand=split "Live substitution is the bees knees
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set hidden
set noswapfile
set grepprg=rg\ --vimgrep\ --ignore-case
let loaded_matchparen = 1 "highlighting matching pairs is slow
let g:ale_virtualtext_cursor = 1
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = 'PSR2'
let g:picker_custom_find_executable = 'fd'
let g:picker_custom_find_flags = "--type f --hidden"

call coc#add_extension('coc-json', 'coc-git', 'coc-phpls', 'coc-css', 'coc-html', 'coc-tslint', 'coc-tsserver', 'coc-snippets')

augroup init_vim
    autocmd!
    autocmd BufWritePost init.vim source %
augroup END

colorscheme monotone
