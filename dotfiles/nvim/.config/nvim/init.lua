local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug 'machakann/vim-sandwich'
    Plug 'saghen/blink.cmp'
    Plug 'srstevenson/vim-picker'
    Plug 'tpope/vim-fugitive'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'github/copilot.vim'
vim.call('plug#end')

vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split' --Live substitution is the bees knees
vim.opt.shiftwidth = 4 -- indentation should be 4 spaces when we use >> and <<
vim.opt.swapfile = false
vim.keymap.set('n', '<c-p>', '<Plug>(PickerEdit)')
vim.keymap.set('i', ';', '<esc>mzA;<esc>`z')
vim.keymap.set('t', '<esc>', '<c-\\><c-n>')
vim.cmd('packadd cfilter')
vim.cmd('set path +=/home/joe/Documents/work') -- So we can gf to stuff from anywhere (work related)

vim.lsp.config['intelephense'] = {
    cmd = { 'intelephense', '--stdio' },
    filetypes = { 'php' },
    root_markers = { 'composer.json' }
}

vim.lsp.enable('intelephense')
