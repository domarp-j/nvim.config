-- REST client
-- https://neovim.getkulala.net/docs/usage/basic-usage

return {
  'mistweaverco/kulala.nvim',
  keys = {
    { '<leader>ks', function() require('kulala').run() end, desc = 'Send request' },
    { '<leader>ka', function() require('kulala').run_all() end, desc = 'Send all requests' },
    { '<leader>kb', function() require('kulala').scratchpad() end, desc = 'Open scratchpad' },
  },
  ft = { 'http', 'rest' },
  opts = {
    global_keymaps = false,
    global_keymaps_prefix = '<leader>k',
    kulala_keymaps_prefix = '',
  },
}
