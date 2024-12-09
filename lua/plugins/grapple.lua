return {
  'cbochs/grapple.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', lazy = true },
  },
  opts = {
    scope = 'git',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>ml', '<cmd>Grapple toggle<cr>', desc = '[M]ark/Unmark [L]ine' },
    { '<leader>mm', '<cmd>Grapple toggle_tags<cr>', desc = 'View [M]ark [M]enu' },
  },
}
