return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local function xcodebuild_device()
      if vim.g.xcodebuild_platform == 'macOS' then
        return '󰀵 macOS'
      end

      local deviceIcon = ''
      if vim.g.xcodebuild_platform and vim.g.xcodebuild_platform:match 'watch' then
        deviceIcon = '􀟤'
      elseif vim.g.xcodebuild_platform and vim.g.xcodebuild_platform:match 'tv' then
        deviceIcon = '􀡴'
      elseif vim.g.xcodebuild_platform and vim.g.xcodebuild_platform:match 'vision' then
        deviceIcon = '􁎖'
      else
        deviceIcon = '􀟜'
      end

      if vim.g.xcodebuild_os then
        return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name .. ' (' .. vim.g.xcodebuild_os .. ')'
      end

      if vim.g.xcodebuild_device_name then
        return deviceIcon .. ' ' .. vim.g.xcodebuild_device_name
      end

      return ''
    end

  local colors = {
	surface0 = '#45475a',    -- palette 0
	red      = '#f38ba8',    -- palette 1, 9
	green    = '#a6e3a1',    -- palette 2, 10
	yellow   = '#f9e2af',    -- palette 3, 11
	blue     = '#89b4fa',    -- palette 4, 12
	pink     = '#f5c2e7',    -- palette 5, 13
	teal     = '#94e2d5',    -- palette 6, 14
	subtext1 = '#a6adc8',    -- palette 7
	surface1 = '#585b70',    -- palette 8
	subtext0 = '#bac2de',    -- palette 15
	base     = '#1e1e2e',    -- background
	text     = '#cdd6f4',    -- foreground
	rosewater = '#f5e0dc',   -- cursor-color
	mantle   = '#11111b',    -- cursor-text
	surface2 = '#353749',    -- selection-background
  }

  local bubbles_theme = {
    normal = {
      a = { fg = colors.base, bg = colors.pink },
      b = { fg = colors.text, bg = colors.surface0 },
      c = { fg = colors.text },
    },

    insert = { a = { fg = colors.base, bg = colors.blue } },
    visual = { a = { fg = colors.base, bg = colors.teal } },
    replace = { a = { fg = colors.base, bg = colors.red } },

    inactive = {
      a = { fg = colors.subtext1, bg = colors.surface1 },
      b = { fg = colors.subtext1, bg = colors.surface1 },
      c = { fg = colors.subtext1 },
    },
  }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = bubbles_theme,
        component_separators = { left = '', right = '' },
        section_separators = { left = ' ', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 200,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = {
          -- Errors
          {
            function()
              local lsp_diagnostics = vim.diagnostic.get(0)
              local errors = 0

              for _, diagnostic in ipairs(lsp_diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                  errors = errors + 1
                end
              end

              -- Check quickfix for build errors if no LSP diagnostics
              if #lsp_diagnostics == 0 then
                local qflist = vim.fn.getqflist()
                for _, item in ipairs(qflist) do
                  if item.type == 'E' or item.text:lower():match 'error' then
                    errors = errors + 1
                  end
                end
              end

              return errors > 0 and ('󰅚 ' .. errors) or ''
            end,
            color = { fg = '#f38ba8' }, -- red
            separator = { left = '', right = '' },
            cond = function()
              local lsp_diagnostics = vim.diagnostic.get(0)
              local errors = 0

              for _, diagnostic in ipairs(lsp_diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                  errors = errors + 1
                end
              end

              if errors == 0 and #lsp_diagnostics == 0 then
                local qflist = vim.fn.getqflist()
                for _, item in ipairs(qflist) do
                  if item.type == 'E' or item.text:lower():match 'error' then
                    errors = errors + 1
                  end
                end
              end

              return errors > 0
            end,
          },
          -- Warnings
          {
            function()
              local lsp_diagnostics = vim.diagnostic.get(0)
              local warnings = 0

              for _, diagnostic in ipairs(lsp_diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.WARN then
                  warnings = warnings + 1
                end
              end

              -- Check quickfix for build warnings if no LSP diagnostics
              if #lsp_diagnostics == 0 then
                local qflist = vim.fn.getqflist()
                for _, item in ipairs(qflist) do
                  if item.type == 'W' or item.text:lower():match 'warning' then
                    warnings = warnings + 1
                  end
                end
              end

              return warnings > 0 and ('󰀪 ' .. warnings) or ''
            end,
            color = { fg = '#f9e2af' }, -- yellow
            separator = { left = '', right = '' },
            cond = function()
              local lsp_diagnostics = vim.diagnostic.get(0)
              local warnings = 0

              for _, diagnostic in ipairs(lsp_diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.WARN then
                  warnings = warnings + 1
                end
              end

              if warnings == 0 and #lsp_diagnostics == 0 then
                local qflist = vim.fn.getqflist()
                for _, item in ipairs(qflist) do
                  if item.type == 'W' or item.text:lower():match 'warning' then
                    warnings = warnings + 1
                  end
                end
              end

              return warnings > 0
            end,
          },
          -- Info
          {
            function()
              local lsp_diagnostics = vim.diagnostic.get(0)
              local info = 0

              for _, diagnostic in ipairs(lsp_diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.INFO then
                  info = info + 1
                end
              end

              return info > 0 and ('󰋽 ' .. info) or ''
            end,
            color = { fg = '#89b4fa' }, -- light blue
            separator = { left = '', right = '' },
            cond = function()
              local lsp_diagnostics = vim.diagnostic.get(0)
              local info = 0

              for _, diagnostic in ipairs(lsp_diagnostics) do
                if diagnostic.severity == vim.diagnostic.severity.INFO then
                  info = info + 1
                end
              end

              return info > 0
            end,
          },
        },
        lualine_c = { 'filename' },
        lualine_x = {
          {
            function()
              if vim.g.xcodebuild_running_build_test then
                return '󰑮 Building...'
              elseif vim.g.xcodebuild_running_test then
                return '󰙨 Testing...'
              end
              return ''
            end,
            color = { fg = '#f9e2af' },
            cond = function()
              return vim.g.xcodebuild_running_build_test or vim.g.xcodebuild_running_test
            end,
          },

          { "' ' .. (vim.g.xcodebuild_last_status or '')", color = { fg = 'Gray' } },
          { "'󰙨 ' .. (vim.g.xcodebuild_test_plan or '')", color = { fg = '#a6e3a1', bg = '#161622' } },
          { xcodebuild_device, color = { fg = '#f9e2af', bg = '#161622' } },
          'filetype',
        },
        lualine_y = {
          { 'branch', separator = { left = '' }, right_padding = 2 },
        },
        lualine_z = {
          'location',
          { 'progress', separator = { right = '' }, padding = { left = 0, right = 1 } },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
