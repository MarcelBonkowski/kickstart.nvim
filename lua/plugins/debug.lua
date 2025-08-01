return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'wojciech-kulik/xcodebuild.nvim',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
  },
  config = function()
    local xcodebuild = require('xcodebuild.integrations.dap')
    local codelldbPath = os.getenv('HOME') .. '/tools/extension/adapter/codelldb'

    xcodebuild.setup(codelldbPath)

    -- Debug keymaps
    vim.keymap.set('n', '<leader>dd', xcodebuild.build_and_debug, { desc = 'Build & Debug' })
    vim.keymap.set('n', '<leader>dr', xcodebuild.debug_without_build, { desc = 'Debug Without Building' })
    vim.keymap.set('n', '<leader>dt', xcodebuild.debug_tests, { desc = 'Debug Tests' })
    vim.keymap.set('n', '<leader>dT', xcodebuild.debug_class_tests, { desc = 'Debug Class Tests' })

    -- Breakpoint management
    vim.keymap.set('n', '<leader>b', xcodebuild.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', xcodebuild.toggle_message_breakpoint, { desc = 'Toggle Message Breakpoint' })
    vim.keymap.set('n', '<leader>dx', xcodebuild.terminate_session, { desc = 'Terminate Debugger' })

    -- Standard DAP keymaps
    local dap = require('dap')
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, { desc = 'Debug: Run to Cursor' })
  end,
}