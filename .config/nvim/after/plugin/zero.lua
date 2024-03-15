local zero = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true
})

zero.on_attach(function(_client, bufnr)
  zero.default_keymaps({ buffer = bufnr })

  zero.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['tsserver'] = {'javascript', 'typescript'},
    ['svelte-language-server'] = {'svelte'},
    ['rust_anaylzer'] = {'rust'},
  }
})
end)

-- require('lspconfig').rust_anaylzer.setup({
-- })

zero.setup()
