call plug#begin()
    Plug 'janko-m/vim-test'
    Plug 'joereynolds/vim-minisnip'
    Plug 'jsfaint/gen_tags.vim'
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    " Plug 'kristijanhusak/deoplete-phpactor'
    Plug 'Lokaltog/vim-monotone'
    Plug 'machakann/vim-sandwich'
    Plug 'phpactor/phpactor', { 'do': 'composer install' }
    " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'w0rp/ale'
    Plug 'ap/vim-css-color'
    Plug 'simeji/winresizer'
    Plug 'neoclide/coc.nvim', {'do': 'npm install'}

    Plug 'leafgarland/typescript-vim'
    Plug 'Quramy/tsuquyomi'
    Plug '~/programs/duplo.vim'
call plug#end()

silent! source ~/programs/configs/dotfiles/nvim/private.vim
source ~/programs/configs/dotfiles/nvim/abbreviations.vim

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>


" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>

"DIY autoclosing
inoremap (; ();<left><left>
inoremap [; [];<left><left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap {<cr> {<cr>}<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap " ""<left>
inoremap ' ''<left>
inoremap ` ``<left>
inoremap ``` ```<cr>```<esc>O

"Delete the if/loop but not the content
nnoremap da% $%dd<c-o>dd

"misc
tnoremap <esc> <c-\><c-n>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap ?? :Rg<cr>

"move codeblocks
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv

augroup init_vim
    autocmd!
    autocmd BufWritePost init.vim source %
    autocmd FileType php setlocal omnifunc=phpactor#Complete
    autocmd FileType markdown setlocal textwidth=80 spell nonumber norelativenumber
augroup END

command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set cscopequickfix=s-,c-,d-,i-,t-,e-,a- "cscope results should populate quickfix
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%y%m%=%f[%02p%%]
set relativenumber "Turn on relative numbering for all lines
set inccommand=split "Live substitution is the bees knees
set ignorecase "Ignore cases when searching
set expandtab "Change tabs into spaces
set noswapfile "it's 2017, people!
set number "Show line numbers
set viminfo='100,<100000,s100000
set mouse=a "mouse support
set hidden

let php_sql_query = 1
let g:ale_virtualtext_cursor = 1
let g:ale_fixers = {
            \'html': ['tidy'],
            \'php': ['php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'], 
            \'python': ['autopep8', 'trim_whitespace'],
            \'markdown': ['remove_trailing_lines', 'trim_whitespace'],
            \'typescript': ['prettier'],
            \}
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard = "PSR2"
" let g:deoplete#enable_at_startup = 1

"Performance improvements
set synmaxcol=200 "Don't bother highlighting anything over 200 chars
let loaded_matchparen = 1 "highlighting matching pairs is slow

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-case
endif

"fzf"
nnoremap <c-p> :GFiles<cr>
nnoremap <leader>b :BTags<cr>
nnoremap <leader>df :Tags<cr>

"vim-test   
function! DockerTransform(cmd) abort    
    return 'docker-compose exec php ' . a:cmd
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'
let g:test#strategy = 'neovim'

nnoremap <f4> :ALEFix<cr>
nnoremap <f5> :TestFile<cr>
nnoremap <f6> :TestNearest<cr>

colorscheme monotone
