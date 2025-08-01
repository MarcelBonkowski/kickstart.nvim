return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        swift = { 'swiftformat' },
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
      },
      formatters = {
        swiftformat = {
          args = function(self, ctx)
            local args = {}
            -- Look for project config files
            local config_files = { '.swiftformat', '.swiftformat.yml', '.swiftformat.yaml' }
            local found_config = false
            for _, config_file in ipairs(config_files) do
              local config_path = vim.fs.find(config_file, { upward = true, path = ctx.dirname })[1]
              if config_path then
                table.insert(args, '--config')
                table.insert(args, config_path)
                found_config = true
                break
              end
            end
            -- Fallback config when no project config is found
            if not found_config then
              local default_args = {
                '--swiftversion', '6.1',
                '--exclude', 'Pods,Carthage,Generated,Build,.build,DerivedData',
                '--indent', '4',
                '--maxwidth', '120',
                '--wraparguments', 'before-first',
                '--wrapparameters', 'before-first',
                '--wrapcollections', 'before-first',
                '--closingparen', 'balanced',
                '--commas', 'always',
                '--trimwhitespace', 'always',
                '--allman', 'false',
                '--stripunusedargs', 'closure-only',
                '--self', 'remove',
                '--importgrouping', 'testable-last',
                '--typeattributes', 'prev-line',
                '--funcattributes', 'prev-line',
                '--storedvarattrs', 'same-line',
                '--guardelse', 'auto',
                '--elseposition', 'same-line',
                '--voidtype', 'void',
                '--shortoptionals', 'except-properties',
                '--semicolons', 'never',
                '--ranges', 'spaced',
                '--patternlet', 'hoist',
                '--linebreaks', 'lf',
                '--header', 'strip',
                '--wrapenumcases', 'always',
              }
              
              -- Add enabled rules individually
              local enable_rules = {
                'redundantBackticks', 'redundantBreak', 'redundantClosure', 'redundantExtensionACL',
                'redundantFileprivate', 'redundantGet', 'redundantInit', 'redundantInternal',
                'redundantLet', 'redundantLetError', 'redundantNilInit', 'redundantObjc',
                'redundantOptionalBinding', 'redundantParens', 'redundantPattern', 'redundantPublic',
                'redundantRawValues', 'redundantReturn', 'redundantSelf', 'redundantStaticSelf',
                'redundantType', 'redundantTypedThrows', 'redundantVoidReturnType', 'duplicateImports',
                'unusedArguments', 'strongOutlets', 'strongifiedSelf', 'preferKeyPath',
                'preferForLoop', 'preferCountWhere', 'hoistAwait', 'hoistTry', 'hoistPatternLet',
                'trailingClosures', 'typeSugar', 'initCoderUnavailable', 'fileHeader',
                'blankLineAfterImports', 'blankLinesAroundMark', 'blankLinesBetweenScopes',
                'blankLinesAtEndOfScope', 'blankLinesAtStartOfScope', 'blankLinesBetweenChainedFunctions',
                'consistentSwitchCaseSpacing', 'wrapLoopBodies', 'wrapSingleLineComments',
                'sortImports', 'sortTypealiases', 'opaqueGenericParameters', 'conditionalAssignment',
                'genericExtensions', 'extensionAccessControl', 'modifierOrder', 'todos', 'braces'
              }
              
              -- Add disabled rules individually
              local disable_rules = {
                'organizeDeclarations', 'sortedSwitchCases', 'wrapConditionalBodies', 'sortSwitchCases',
                'wrapSwitchCases', 'markTypes', 'isEmpty', 'acronyms', 'blockComments', 'docComments',
                'emptyExtensions', 'blankLineAfterSwitchCase', 'blankLinesAfterGuardStatements',
                'blankLinesBetweenImports', 'environmentEntry', 'noExplicitOwnership', 'noGuardInTests',
                'preferSwiftTesting', 'privateStateVariables', 'propertyTypes', 'redundantEquatable',
                'redundantMemberwiseInit', 'redundantProperty', 'singlePropertyPerLine', 'sortDeclarations',
                'throwingTests', 'unusedPrivateDeclarations', 'urlMacro', 'wrapMultilineConditionalAssignment',
                'wrapMultilineFunctionChains', 'wrapMultilineStatementBraces'
              }
              
              -- Add all default args
              for _, arg in ipairs(default_args) do
                table.insert(args, arg)
              end
              
              -- Add enable rules
              for _, rule in ipairs(enable_rules) do
                table.insert(args, '--enable')
                table.insert(args, rule)
              end
              
              -- Add disable rules
              for _, rule in ipairs(disable_rules) do
                table.insert(args, '--disable')
                table.insert(args, rule)
              end
            end
            return args
          end,
        },
      },
      format_on_save = function(bufnr)
        -- Disable format_on_save for certain filetypes
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      log_level = vim.log.levels.ERROR,
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}