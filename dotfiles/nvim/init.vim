call plug#begin()
    Plug 'Lokaltog/vim-monotone'
    Plug 'joereynolds/vim-minisnip'
    Plug 'jsfaint/gen_tags.vim'
    Plug 'junegunn/fzf',           { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'w0rp/ale'
    Plug 'padawan-php/deoplete-padawan'
    Plug 'machakann/vim-sandwich'
    Plug 'phpactor/phpactor', { 'do': 'composer install', 'branch': 'develop' }
    Plug 'kristijanhusak/deoplete-phpactor'
    Plug 'stefandtw/quickfix-reflector.vim'
call plug#end()

colorscheme monotone

silent! source ~/programs/configs/dotfiles/nvim/private.vim
source ~/programs/configs/dotfiles/nvim/abbreviations.vim

"Clear the search when we press space
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
nnoremap gf :e <cfile><cr>
tnoremap <esc> <c-\><c-n>
nnoremap <leader>ev :e $MYVIMRC<cr>

augroup init_vim
    autocmd!
    autocmd BufWritePre,BufRead *.html :normal gg=G
    autocmd BufWritePost init.vim source %
    autocmd FileType php setlocal omnifunc=phpactor#Complete
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
let php_htmlInStrings = 1
let g:ale_fixers = {'php': ['php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'], 'markdown': ['remove_trailing_lines', 'trim_whitespace']}
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

"fugitive
nnoremap <leader>gb :Gblame<cr>

"fzf"
nnoremap <c-p> :GFiles<cr>
nnoremap <leader>b :BTags<cr>
nnoremap <leader>df :Tags<cr>
nnoremap <leader>t :tabnew<cr>

"phpactor   
nnoremap <leader>pcm :call phpactor#ContextMenu()<cr>

"vim-minisnip
let g:minisnip_dir = '~/programs/configs/dotfiles/nvim/minisnip/'

" Dumping ground below, beware
""phpstorm jealousies
""
"" - When you type $this-> It automaticalls adds the >
""
""TODO Put this in ftplugin
augroup vimrc_expand
   autocmd!
   autocmd InsertCharPre * call <sid>expand()
augroup END 

function! s:expand() abort
    " Dictionary in the following format
    " key: The default key to return
    " 1: The word that triggers [2] - The thing to proceed the word
    " 2: The snippet that is autocompleted after the word is triggered
    let l:autocompletions = {
        \'-' : ['\V$this\$', '->'],
        \':' : ['\Vself\$', '::']
    \}

    if !has_key(l:autocompletions, v:char)
        return
    endif

    if strpart(getline('.'), 0, col('.') - 1) =~ l:autocompletions[v:char][0]
        let v:char = l:autocompletions[v:char][1]
    end
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

