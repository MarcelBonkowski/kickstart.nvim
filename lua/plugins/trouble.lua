return {
  'folke/trouble.nvim',
  opts = {
    auto_open = false,
    auto_close = true,
    auto_refresh = true,
    focus = false,
    follow = true,
    indent_guides = true,
    max_items = 200,
    multiline = true,
    pinned = false,
    win = { position = 'bottom', size = 10 },
    keys = {
      ['q'] = 'close',
      ['<esc>'] = 'close',
    },
    modes = {
      diagnostics = {
        auto_open = false,
        auto_close = true,
        auto_refresh = true,
        desc = 'Diagnostics from LSP',
        mode = 'diagnostics',
        win = { position = 'bottom', size = 10 },
      },
    },
  },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cs',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
  init = function()
    -- Disable default diagnostic virtual text and signs to use trouble instead
    vim.diagnostic.config({
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })
    
    -- Override default diagnostic navigation to use trouble
    vim.keymap.set('n', '[d', function()
      if require('trouble').is_open('diagnostics') then
        require('trouble').prev({ skip_groups = true, jump = true })
      else
        vim.diagnostic.goto_prev()
      end
    end, { desc = 'Previous diagnostic' })
    
    vim.keymap.set('n', ']d', function()
      if require('trouble').is_open('diagnostics') then
        require('trouble').next({ skip_groups = true, jump = true })
      else
        vim.diagnostic.goto_next()
      end
    end, { desc = 'Next diagnostic' })
    
    vim.keymap.set('n', '<leader>q', function()
      local diagnostics = vim.diagnostic.get()
      local qflist = vim.fn.getqflist()
      
      if #diagnostics > 0 then
        require('trouble').toggle('diagnostics')
      elseif #qflist > 0 then
        require('trouble').toggle('qflist')
      else
        vim.notify('No diagnostics or build errors found', vim.log.levels.INFO)
      end
    end, { desc = 'Toggle diagnostics or build errors' })
  end,
}