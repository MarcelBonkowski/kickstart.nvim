return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    { 'antosha417/nvim-lsp-file-operations', config = true },
  },
  config = function()
    local lspconfig = require 'lspconfig'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'
    local capabilities = cmp_nvim_lsp.default_capabilities()

    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = 'Show line diagnostics'
      vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

      opts.desc = 'Show documentation for what is under cursor'
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

      opts.desc = 'Go to declaration'
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

      opts.desc = 'Go to definition'
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

      opts.desc = 'Go to implementation'
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

      opts.desc = 'Go to type definition'
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)

      opts.desc = 'See available code actions'
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

      opts.desc = 'Smart rename'
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

      opts.desc = 'Show buffer diagnostics'
      vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts)

      opts.desc = 'Show LSP references'
      vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

      opts.desc = 'Go to previous diagnostic'
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

      opts.desc = 'Go to next diagnostic'
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

      opts.desc = 'Restart LSP'
      vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
    end
  end,
}

