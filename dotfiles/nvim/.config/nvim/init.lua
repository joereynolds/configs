vim.pack.add({
    'https://github.com/machakann/vim-sandwich',
    { src = 'https://github.com/saghen/blink.cmp', version = "v1" },
    'https://github.com/srstevenson/vim-picker',
    'https://github.com/stefandtw/quickfix-reflector.vim',
    'https://github.com/tpope/vim-fugitive',
})

vim.cmd.packadd('cfilter')
vim.cmd.packadd('nvim.undotree')
vim.lsp.enable({'intelephense', 'pylsp'}) -- ~/.config/nvim/lsp
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.path:append('/home/joe/Documents/work')
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.keymap.set('n', '<c-p>', '<Plug>(PickerEdit)')
vim.keymap.set('i', ';', '<esc>mzA;<esc>`z')
vim.diagnostic.config({ virtual_text = true})

require('blink.cmp').setup()
