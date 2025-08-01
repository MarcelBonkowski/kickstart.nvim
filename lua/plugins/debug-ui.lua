return {
  'rcarriga/nvim-dap-ui',
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
      controls = {
        element = 'repl',
        enabled = true,
      },
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      icons = { collapsed = '', expanded = '', current_frame = '' },
      layouts = {
        {
          elements = {
            { id = 'stacks', size = 0.25 },
            { id = 'scopes', size = 0.25 },
            { id = 'breakpoints', size = 0.25 },
            { id = 'watches', size = 0.25 },
          },
          position = 'left',
          size = 60,
        },
        {
          elements = {
            { id = 'repl', size = 0.35 },
            { id = 'console', size = 0.65 },
          },
          position = 'bottom',
          size = 10,
        },
      },
    })

    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end

    -- Toggle UI manually
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: See last session result.' })
  end,
}