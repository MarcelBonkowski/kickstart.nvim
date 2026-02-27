return {
  'ThePrimeagen/99',
  dependencies = {
    { 'saghen/blink.compat', version = '2.*' },
  },
  config = function()
    local _99 = require('99')

    -- Get current working directory for logging
    local cwd = vim.uv.cwd()
    local basename = vim.fs.basename(cwd)

    _99.setup({
      -- provider = _99.Providers.ClaudeCodeProvider, -- default: OpenCodeProvider
      model = 'anthropic/claude-sonnet-4-5', -- Valid OpenCode model
      logger = {
        level = _99.DEBUG,
        path = '/tmp/' .. basename .. '.99.debug',
        print_on_error = true,
      },
      tmp_dir = './tmp',

      -- Completions: #rules and @files in the prompt buffer
      completion = {
        -- Detect which completion engine you're using
        source = 'blink', -- Change to 'cmp' if using nvim-cmp
        custom_rules = {},
        files = {
          enabled = true,
        },
      },

      -- Auto-add AGENT.md files from project directories
      md_files = {
        'AGENT.md',
        'AGENTS.md',
      },
    })

    -- Visual selection mode - replace selection with AI result
    vim.keymap.set('v', '<leader>9v', function()
      _99.visual()
    end, { desc = '99: Visual selection' })

    -- Cancel all in-flight requests
    vim.keymap.set('n', '<leader>9x', function()
      _99.stop_all_requests()
    end, { desc = '99: Stop all requests' })

    -- Search across project with AI
    vim.keymap.set('n', '<leader>9s', function()
      _99.search()
    end, { desc = '99: Search' })

    -- Open last interaction results
    vim.keymap.set('n', '<leader>9o', function()
      _99.open()
    end, { desc = '99: Open last interaction' })

    -- View logs
    vim.keymap.set('n', '<leader>9l', function()
      _99.view_logs()
    end, { desc = '99: View logs' })

    -- Clear previous requests
    vim.keymap.set('n', '<leader>9c', function()
      _99.clear_previous_requests()
    end, { desc = '99: Clear previous requests' })
  end,
}
