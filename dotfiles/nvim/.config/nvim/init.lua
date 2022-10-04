local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug 'machakann/vim-sandwich'
    Plug('neoclide/coc.nvim', {branch = 'release'})
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
vim.g.loaded_matchparen = 1 --Crazy slow and annoying highlighting
vim.g.loaded_netrwPlugin = 1 -- https://github.com/vim/vim/issues/5073

local augroup = vim.api.nvim_create_augroup('init_vim', {clear = true})

-- Re source init.vim on save
vim.api.nvim_create_autocmd(
    'BufWritePost',
    {
        group = augroup,
        pattern = 'init.vim',
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

vim.cmd('colorscheme monotone')
vim.cmd('packadd cfilter')

vim.o.grepprg = 'rg --vimgrep --ignore-case'

vim.keymap.set('n', ']b', ':bnext<cr>')
vim.keymap.set('n', '[b', ':bprevious<cr>')
vim.keymap.set('n', '[a',  '<Plug>(ale_previous)')
vim.keymap.set('n', ']a',  '<Plug>(ale_next)')
vim.keymap.set('n', ']r',  '<Plug>(coc-references)')
vim.keymap.set('n', ']d',  '<Plug>(coc-definition)')
vim.keymap.set('v', ']f', '<Plug>(coc-format-selected)')
vim.keymap.set('n', '<c-p>', '<Plug>(PickerEdit)')
vim.keymap.set('n', ']q', ':cnext<cr>')
vim.keymap.set('n', '[q', ':cprevious<cr>')
vim.keymap.set('i', '```', '```<cr>```<esc>O')
vim.keymap.set('i', ';', '<esc>mzA;<esc>`z')
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('n', '<silent> K', ':call CocAction("doHover")<cr>')

-- Find out the correct vim opts for these instead of being lazy and using cmd
vim.cmd("command! -nargs=+ F execute 'silent grep!' <q-args> | cw | redraw!")
vim.cmd("call coc#add_extension('coc-haxe', 'coc-json', 'coc-git', 'coc-phpls', 'coc-css', 'coc-html', 'coc-tslint', 'coc-tsserver', 'coc-snippets')")
