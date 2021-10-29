local nvim_terminal = require('nvim-terminal')
nvim_terminal.setup({
    window = {
        position = 'botright',
        split = 'sp',
        width = 50,
        height = 15,
    },

    disable_default_keymaps = false,
    toggle_keymap = '<leader>j'
})