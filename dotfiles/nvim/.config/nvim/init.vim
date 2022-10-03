lua <<EOF
    local Plug = vim.fn['plug#']

    vim.call('plug#begin')
        Plug 'machakann/vim-sandwich'
        Plug 'neoclide/coc.nvim'
        Plug 'srstevenson/vim-picker'
        Plug 'tpope/vim-commentary'
        Plug 'tpope/vim-fugitive'
        Plug 'dense-analysis/ale'
        Plug 'tmsvg/pear-tree'
        Plug 'stefandtw/quickfix-reflector.vim'
        Plug 'Lokaltog/vim-monotone'
    vim.call('plug#end')


    vim.opt.expandtab = true
    vim.opt.ignorecase = true
    vim.opt.swapfile = false
    vim.opt.inccommand = 'split' --Live substitution is the bees knees
    vim.opt.mouse = 'a'
    vim.opt.shiftwidth = 4 -- indentation should be 4 spaces when we use >> and <<

    vim.g.ale_sign_column_always = 1
    vim.g.ale_virtualtext_cursor = 1

    local augroup = vim.api.nvim_create_augroup('init_vim', {clear = true})

    -- Re source init.vim on save
    vim.api.nvim_create_autocmd(
        'BufWritePost',
        {
            pattern = 'init.vim',
            group = augroup,
            command = 'source %'
        }
    )

    -- Make quickfix span the entire window
    vim.api.nvim_create_autocmd(
        'FileType',
        {
            group = augroup,
            pattern = 'qf',
            command = 'wincmd J'
        }
    )
EOF

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
nmap <c-p> <Plug>(PickerEdit)
nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>
inoremap ``` ```<cr>```<esc>O
inoremap ; <esc>mzA;<esc>`z
tnoremap <esc> <c-\><c-n>
nnoremap <silent> K :call CocAction('doHover')<cr>

set grepprg=rg\ --vimgrep\ --ignore-case
let loaded_matchparen = 1 "Crazy slow and annoying highlighting
let loaded_netrwPlugin = 1 " https://github.com/vim/vim/issues/5073

colorscheme monotone
