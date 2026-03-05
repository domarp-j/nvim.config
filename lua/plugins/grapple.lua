-- grapple.nvim
-- File tagging and navigation. Tag files and jump between them quickly.
-- Use <leader>m to tag/untag, <leader>M to open the tags window,
-- and <leader>1-9 to jump directly to a tagged file.

return {
  'cbochs/grapple.nvim',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>M', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
    { '<leader>gf', '<cmd>Grapple toggle<cr>', desc = '[G]rapple [F]ile' },
    { '<leader>gm', '<cmd>Grapple toggle_tags<cr>', desc = 'View [G]rapple [M]enu' },
    { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Grapple select tag 1' },
    { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Grapple select tag 2' },
    { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select tag 3' },
    { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Grapple select tag 4' },
  },
}
