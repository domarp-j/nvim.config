-- Quickly navigate through files you access frequently

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
    { '<leader>gf', '<cmd>Grapple toggle<cr>', desc = '[G]rapple [F]ile' },
    { '<leader>gm', '<cmd>Grapple toggle_tags<cr>', desc = 'View [G]rapple [M]enu' },
  },
}
