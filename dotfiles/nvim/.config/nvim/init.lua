local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug 'machakann/vim-sandwich'
    Plug ('saghen/blink.cmp', { tag = '*' })
    Plug 'srstevenson/vim-picker'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'tpope/vim-fugitive'
    Plug('michaelb/sniprun', { ['do'] = 'sh ./install.sh' })
vim.call('plug#end')

vim.lsp.enable('intelephense') -- ~/.config/nvim/lsp/intelephense.lua
vim.lsp.enable('pylsp') -- ~/.config/nvim/lsp/pylsp.lua
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.path:append('/home/joe/Documents/work')
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.keymap.set('n', '<c-p>', '<Plug>(PickerEdit)')
vim.keymap.set('i', ';', '<esc>mzA;<esc>`z')
vim.cmd('packadd cfilter')
vim.diagnostic.config({ virtual_text = true})
vim.keymap.set('n', '<c-c><c-c>', function() require('sniprun').run() end, { silent = true })

require('sniprun').setup({
    display = { "TempFloatingWindow" },
})

require('blink.cmp').setup {
    completion = {
        documentation = { auto_show = true },
        menu = {
            draw = {
                columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } },
            },
        },
    },
}
