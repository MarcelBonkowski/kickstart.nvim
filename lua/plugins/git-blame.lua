return {
  'f-person/git-blame.nvim',
  event = 'VeryLazy',
  opts = {
    enabled = true,
    message_template = ' <summary> • <date> • <author> • <<sha>>',
    date_format = '%c',
    virtual_text_column = 1,
  },
  keys = {
    { '<leader>gB', '<cmd>GitBlameToggle<cr>', desc = 'Toggle Git Blame' },
    { '<leader>gbo', '<cmd>GitBlameOpenCommitURL<cr>', desc = 'Open Commit URL' },
    { '<leader>gbc', '<cmd>GitBlameCopyCommitURL<cr>', desc = 'Copy Commit URL' },
    { '<leader>gbs', '<cmd>GitBlameCopySHA<cr>', desc = 'Copy SHA' },
  },
}