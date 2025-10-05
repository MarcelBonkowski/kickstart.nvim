return {
  {
    'akinsho/flutter-tools.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = function()
      require('flutter-tools').setup({
        ui = {
          border = 'rounded',
          notification_style = 'native',
        },
        decorations = {
          statusline = {
            app_version = false,
            device = true,
          }
        },
        debugger = {
          enabled = false,
          run_via_dap = false,
        },
        flutter_path = nil,
        flutter_lookup_cmd = 'which flutter',
        fvm = false,
        widget_guides = {
          enabled = false,
        },
        flutter_path = nil,
        flutter_lookup_cmd = nil,
        root_patterns = { '.git', 'pubspec.yaml' },
        fvm = false,
        widget_guides = {
          enabled = false,
        },
        closing_tags = {
          highlight = 'ErrorMsg',
          prefix = '//',
          enabled = true
        },
        dev_log = {
          enabled = true,
          notify_errors = false,
          open_cmd = 'tabedit',
        },
        dev_tools = {
          autostart = false,
          auto_open_browser = false,
        },
        outline = {
          open_cmd = '30vnew',
          auto_open = false
        },
        lsp = {
          color = {
            enabled = false,
            background = false,
            background_color = nil,
            foreground = false,
            virtual_text = false,
            virtual_text_str = '■',
          },
          flags = {
            debounce_text_changes = 500,
            allow_incremental_sync = true,
          },
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>fc', function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { 'source.organizeImports' },
                }
              })
            end, { buffer = bufnr, desc = 'Flutter: Organize Imports' })
          end,
          capabilities = function(config)
            local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
            if ok then
              config.capabilities = vim.tbl_deep_extend('force', config.capabilities or {}, cmp_nvim_lsp.default_capabilities())
            end
            return config.capabilities
          end,
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
            analysisExcludedFolders = { 
              vim.fn.expand('$HOME/AppData/Local/Pub/Cache'),
              vim.fn.expand('$HOME/.pub-cache'),
              vim.fn.expand('$HOME/fvm'),
              'build/',
              '.dart_tool/',
              '.packages',
              'android/',
              'ios/',
              'linux/',
              'macos/',
              'web/',
              'windows/',
            },
            renameFilesWithClasses = 'prompt',
            enableSnippets = true,
            lineLength = 160,
            includeBuiltInLints = false,
            updateImportsOnRename = false,
            suggestFromUnimportedLibraries = false,
            closingLabels = false,
            outline = false,
            flutterOutline = false,
          }
        }
      })
    end,
  },
  {
    'akinsho/pubspec-assist.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    ft = { 'yaml' },
    event = 'BufEnter pubspec.yaml',
    config = function()
      require('pubspec-assist').setup()
    end,
  },
  {
    'RobertBrunhage/flutter-riverpod-snippets',
    ft = 'dart',
  },
}