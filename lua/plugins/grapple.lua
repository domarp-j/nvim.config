-- grapple.nvim
-- File tagging and navigation. Tag files and jump between them quickly.
-- Use <leader>gf to tag/untag and <leader>gm to open the tags window.

return {
  'cbochs/grapple.nvim',
  keys = {
    { '<leader>gf', '<cmd>Grapple toggle<cr>', desc = '[G]rapple [F]ile' },
    { '<leader>gm', '<cmd>Grapple toggle_tags<cr>', desc = 'View [G]rapple [M]enu' },
  },
}
