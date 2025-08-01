return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'nvim-telescope/telescope.nvim', -- optional
  },
  config = function()
    require('neogit').setup({
      -- Add any specific configuration here if needed
    })
  end,
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
  },
}