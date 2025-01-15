-- Comprehensive search and replace
return {
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      { '<leader>sp', '<cmd>Spectre<cr>', desc = '[S]earch [S]pectre' },
    },
  },
}
