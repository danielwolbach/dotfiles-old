require('nvim-tree').setup({
    auto_close = true,
    hijack_cursor = true,
    view = {
        width = 40,
        height = 30
    }
})

vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', {noremap = true, silent =  true})
