-- diffview.nvim
-- Git diff/review UI. Provides :DiffviewOpen, :DiffviewFileHistory, and related commands for reviewing changes and file history.

return {
  'sindrets/diffview.nvim',
  keys = {
    { '<leader>d', '<cmd>DiffviewOpen<cr>', desc = '[D]iffview', nowait = true },
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
