call plug#begin()
    Plug 'machakann/vim-sandwich'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'dense-analysis/ale'
    Plug 'tmsvg/pear-tree'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'tomasiser/vim-code-dark'
call plug#end()

packadd cfilter
command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
call coc#add_extension('coc-haxe', 'coc-json', 'coc-git', 'coc-phpls', 'coc-css', 'coc-html', 'coc-tslint', 'coc-tsserver', 'coc-snippets')

nmap ]b :bnext<cr>
nmap [b :bprevious<cr>
nmap [a <Plug>(ale_previous)
nmap ]a <Plug>(ale_next)
nmap ]r <Plug>(coc-references)
nmap ]d <Plug>(coc-definition)
vmap ]f <Plug>(coc-format-selected)
nmap <c-p> :CocList gfiles<cr>
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
inoremap ``` ```<cr>```<esc>O
inoremap ; <esc>mzA;<esc>`z
tnoremap <esc> <c-\><c-n>
nnoremap <silent> K :call CocAction('doHover')<cr>

set mouse=a
set expandtab "Change tabs into spaces
set grepprg=rg\ --vimgrep\ --ignore-case
set ignorecase "Ignore cases when searching
set inccommand=split "Live substitution is the bees knees
set noswapfile
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
let loaded_matchparen = 1 "Crazy slow and annoying highlighting
let loaded_netrwPlugin = 1 " https://github.com/vim/vim/issues/5073
let g:ale_virtualtext_cursor = 1
let g:ale_sign_column_always = 1

augroup init_vim
    autocmd!
    autocmd BufWritePost init.vim source %
    autocmd FileType qf wincmd J " Make quickfix span the entire window
    " autocmd BufWritePre * :%s/\s\+$//e "Remove trailing whitespace
augroup END

colorscheme codedark
