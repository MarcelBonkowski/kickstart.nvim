return {
  'wojciech-kulik/xcodebuild.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('xcodebuild').setup({
      code_coverage = {
        enabled = true,
      },
      logs = {
        logs_formatter = 'xcbeautify --disable-colored-output',
      },
    })

    -- Build and Run
    vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<cr>', { desc = 'Toggle Xcodebuild Logs' })
    vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<cr>', { desc = 'Build Project' })
    vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<cr>', { desc = 'Build & Run Project' })
    vim.keymap.set('n', '<leader>xR', '<cmd>XcodebuildRun<cr>', { desc = 'Run Project' })

    -- Testing
    vim.keymap.set('n', '<leader>xt', '<cmd>XcodebuildTest<cr>', { desc = 'Run Tests' })
    vim.keymap.set('n', '<leader>xT', '<cmd>XcodebuildTestClass<cr>', { desc = 'Run This Test Class' })
    vim.keymap.set('n', '<leader>x.', '<cmd>XcodebuildTestSelected<cr>', { desc = 'Run Selected Tests' })

    -- Project Management
    vim.keymap.set('n', '<leader>X', '<cmd>XcodebuildPicker<cr>', { desc = 'Show All Xcodebuild Actions' })
    vim.keymap.set('n', '<leader>xd', '<cmd>XcodebuildSelectDevice<cr>', { desc = 'Select Device' })
    vim.keymap.set('n', '<leader>xs', '<cmd>XcodebuildSelectScheme<cr>', { desc = 'Select Scheme' })
    vim.keymap.set('n', '<leader>xp', '<cmd>XcodebuildSelectTestPlan<cr>', { desc = 'Select Test Plan' })

    -- Code Coverage
    vim.keymap.set('n', '<leader>xc', '<cmd>XcodebuildToggleCodeCoverage<cr>', { desc = 'Toggle Code Coverage' })
    vim.keymap.set('n', '<leader>xC', '<cmd>XcodebuildShowCodeCoverageReport<cr>', { desc = 'Show Code Coverage Report' })

    -- Utilities
    vim.keymap.set('n', '<leader>xq', '<cmd>Telescope quickfix<cr>', { desc = 'Show QuickFix List' })
    vim.keymap.set('n', '<leader>xu', '<cmd>XcodebuildUninstallApp<cr>', { desc = 'Uninstall App' })
    vim.keymap.set('n', '<leader>xf', '<cmd>XcodebuildFailingSnapshots<cr>', { desc = 'Show Failing Snapshots' })
  end,
}