vim.pack.add({
    'https://github.com/machakann/vim-sandwich',
    { src = 'https://github.com/saghen/blink.cmp', version = "v1" },
    'https://github.com/srstevenson/vim-picker',
    'https://github.com/stefandtw/quickfix-reflector.vim',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/TheNoeTrevino/haunt.nvim',
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

-- Haunt (clobbers a few mark mappings but maybe worth it)
vim.keymap.set('n', '[h', ':HauntPrev<cr>')
vim.keymap.set('n', ']h', ':HauntNext<cr>')
vim.keymap.set('n', 'ml', function() require('haunt.picker').show() end)
vim.keymap.set('n', 'mq', function() require('haunt.api').to_quickfix() end)
vim.keymap.set('n', 'my', function() require('haunt.api').yank_locations() end)
vim.keymap.set('n', 'ma', function() require('haunt.api').annotate() end)
vim.keymap.set('n', 'md', function() require('haunt.api').delete() end)

require('blink.cmp').setup()
