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
      integrations = {
        nvim_dap = {
          enabled = true,
        },
        quickfix = {
          enabled = true,
          on_build_failed = function()
            vim.cmd('copen')
          end,
        },
        nvim_lsp = {
          enabled = true,
        },
      },
      commands = {
        extra_build_args = {},
        extra_test_args = {},
        project_search_max_depth = 3,
        cache_disabled = false,
        logs = {
          auto_close_on_app_launch = false,
          auto_close_on_success = true,
          auto_focus = true,
          auto_open_on_failed_tests = true,
          auto_open_on_success_tests = false,
          filetype = 'objc',
          open_command = 'silent botright 20split {path}',
          logs_formatter = 'xcbeautify --disable-colored-output',
          only_summary = false,
          show_warnings = true,
          notify = function(message, severity)
            local silent_commands = {
              'git status --porcelain=v1',
              'git diff --name-only --cached',
              'git add',
              'git reset',
            }
            
            for _, cmd in ipairs(silent_commands) do
              if string.find(message, cmd, 1, true) then
                return
              end
            end
            
            vim.notify(message, severity)
          end,
        },
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