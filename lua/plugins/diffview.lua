-- diffview.nvim
-- Git diff/review UI. Provides :DiffviewOpen, :DiffviewFileHistory, and related commands for reviewing changes and file history.

return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>do', '<cmd>DiffviewOpen<cr>', desc = '[D]iffview [O]pen' },
    { '<leader>dc', '<cmd>DiffviewClose<cr>', desc = '[D]iffview [C]lose' },
  },
  cmd = {
    'DiffviewOpen',
    'DiffviewFileHistory',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewRefresh',
  },
}
