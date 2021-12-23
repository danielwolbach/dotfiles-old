local lsp_installer = require('nvim-lsp-installer')
local lsp_installer_servers = require('nvim-lsp-installer.servers')

local server_names = {'rust_analyzer', 'clangd', 'jdtls', 'sumneko_lua', 'bashls'}

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local on_attach = function(_, bufnr)
    local keybind_opts = {noremap = true, silent =  true}
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', keybind_opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', keybind_opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', keybind_opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', keybind_opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', keybind_opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', keybind_opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', keybind_opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', keybind_opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', keybind_opts)
end

lsp_installer.on_server_ready(function(server)
    server:setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    })
end)

for _, server_name in ipairs(server_names) do
    local server_available, requested_server = lsp_installer_servers.get_server(server_name)
    if server_available and not requested_server:is_installed() then
        requested_server:install()
    end
end

