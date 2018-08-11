call plug#begin()
    Plug 'Lokaltog/vim-monotone'
    Plug 'joereynolds/vim-minisnip'
    Plug 'jsfaint/gen_tags.vim'
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'leafgarland/typescript-vim'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'w0rp/ale'
    Plug 'padawan-php/deoplete-padawan'
    Plug 'machakann/vim-sandwich'
    Plug 'phpactor/phpactor', { 'do': 'composer install', 'branch': 'develop' }
    Plug 'kristijanhusak/deoplete-phpactor'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'KabbAmine/zeavim.vim'
    Plug 'mattn/emmet-vim'
    Plug 'janko-m/vim-test'
    "LSPs
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \}
call plug#end()

silent! source ~/programs/configs/dotfiles/nvim/private.vim
source ~/programs/configs/dotfiles/nvim/abbreviations.vim

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>:set nospell<CR>

nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [b :bprevious<cr>

"window resizing
nnoremap <up> :resize +10<cr>
nnoremap <down> :resize -10<cr>
nnoremap <left> :vertical resize -10<cr>
nnoremap <right> :vertical resize +10<cr>

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

"misc
tnoremap <esc> <c-\><c-n>
nnoremap <leader>ev :e $MYVIMRC<cr>

augroup init_vim
    autocmd!
    autocmd BufWritePre,BufRead *.html :normal gg=G
    " autocmd BufWritePre,BufRead *.json execute '%!python -m json.tool' | w
    autocmd BufWritePost init.vim source %
    autocmd FileType php setlocal omnifunc=phpactor#Complete
    autocmd InsertCharPre * call <sid>expand()
    autocmd FileType markdown setlocal textwidth=80
augroup END

command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!
command! -bang -nargs=? -complete=dir GFiles call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set scrolloff=10 "Keep at least 10 lines in view when the cursor hits the bottom of the buffer
set cscopequickfix=s-,c-,d-,i-,t-,e-,a- "cscope results should populate quickfix
set shiftwidth=4 "indentation should be 4 spaces when we use >> and <<
set statusline=%y%m%=%f[%02p%%]
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
let g:ale_fixers = {
            \'html': ['tidy'],
            \'php': ['php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'], 
            \'markdown': ['remove_trailing_lines', 'trim_whitespace'],
            \'typescript': ['prettier'],
            \}
let g:ale_sign_column_always = 1
let g:ale_php_phpcs_standard="PSR2"
let g:deoplete#enable_at_startup = 1

"Performance improvements
set synmaxcol=200 "Don't bother highlighting anything over 200 chars
let did_install_default_menus = 1 "No point loading gvim menu stuff
let loaded_matchparen = 1 "highlighting matching pairs so slow

if has('nvim')
    set inccommand=split "Live substitution is the bees knees
    set termguicolors
endif

if executable('rg')
    set grepprg=rg\ --vimgrep\ --ignore-case
endif

"emmet  
let g:user_emmet_leader_key='<C-D>'

"fugitive
nnoremap <leader>gb :Gblame<cr>

"fzf"
nnoremap <c-p> :GFiles<cr>
nnoremap <leader>b :BTags<cr>
nnoremap <leader>df :Tags<cr>
nnoremap <leader>t :tabnew<cr>

"SQHEll
let g:sqh_results_limit = 2000

"vim-minisnip
let g:minisnip_dir = '~/programs/configs/dotfiles/nvim/minisnip/'

"vim-test   
" function! DockerTransform(cmd) abort    
"     return 'docker-compose exec php ' . a:cmd
" endfunction

" let g:test#custom_transformations = {'docker': function('DockerTransform')}
" let g:test#transformation = 'docker'
let g:test#strategy = 'neovim'

nnoremap <f4> :ALEFix<cr>
nnoremap <f5> :TestFile<cr>
nnoremap <f6> :TestNearest<cr>

"LSP
let g:LanguageClient_serverCommands = {
\ 'sh': ['bash-language-server', 'start'],
\ 'javascript': ['javascript-typescript-stdio'],
\ 'typescript': ['javascript-typescript-stdio'],
\ 'css': ['css-languageserver', '--stdio'],
\ 'html': ['html-languageserver', '--stdio'],
\ }

" Dumping ground below, beware
""phpstorm jealousies
"" - When you type $this-> It automaticalls adds the >
"" Autocmd is in init_vim
function! s:expand() abort
    " Dictionary in the following format
    " key: The default key to return
    " 1: The word that triggers [2] - The thing to proceed the word
    " 2: The snippet that is autocompleted after the word is triggered
    let l:autocompletions = {
        \'-' : ['\$[a-z]\+', '->'],
        \':' : ['self$', '::']
    \}

    if !has_key(l:autocompletions, v:char)
        return
    endif

    if strpart(getline('.'), 0, col('.') - 1) =~ l:autocompletions[v:char][0]
        let v:char = l:autocompletions[v:char][1]
    end
endfunction

colorscheme monotone
