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
          on_attach = function(client, bufnr)
            -- Set up standard LSP keymaps
            local opts = { noremap = true, silent = true, buffer = bufnr }
            
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

            opts.desc = 'Show LSP references'
            vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

            opts.desc = 'Go to previous diagnostic'
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

            opts.desc = 'Go to next diagnostic'
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

            opts.desc = 'Restart LSP'
            vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts)
            
            -- Flutter-specific keymap
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