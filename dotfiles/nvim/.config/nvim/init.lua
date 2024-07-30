local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug 'machakann/vim-sandwich'
    Plug('neoclide/coc.nvim', {branch = 'release'})
    Plug 'srstevenson/vim-picker'
    Plug 'tpope/vim-fugitive'
    Plug 'stefandtw/quickfix-reflector.vim'
vim.call('plug#end')

vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split' --Live substitution is the bees knees
vim.opt.shiftwidth = 4 -- indentation should be 4 spaces when we use >> and <<
vim.opt.swapfile = false

vim.g.loaded_matchparen = 1 --Crazy slow and annoying highlighting
vim.g.loaded_netrwPlugin = 1 -- https://github.com/vim/vim/issues/5073

vim.keymap.set('n', ']b', ':bnext<cr>')
vim.keymap.set('n', '[b', ':bprevious<cr>')
vim.keymap.set('n', ']r',  '<Plug>(coc-references)')
vim.keymap.set('n', ']d',  '<Plug>(coc-definition)')
vim.keymap.set('v', ']f', '<Plug>(coc-format-selected)')
vim.keymap.set('n', '<c-p>', '<Plug>(PickerEdit)')
vim.keymap.set('n', ']q', ':cnext<cr>')
vim.keymap.set('n', '[q', ':cprevious<cr>')
vim.keymap.set('i', ';', '<esc>mzA;<esc>`z')
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.keymap.set('n', 'K', ':call CocAction("doHover")<cr>')

vim.cmd('packadd cfilter')
vim.cmd("call coc#add_extension('coc-json', 'coc-git', 'coc-phpls', 'coc-css', 'coc-html')")
