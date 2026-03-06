-- neo-tree.nvim
-- File system browser sidebar. Press \ to reveal the current file in the tree; press \ again inside the tree to close it.

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '|', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>nf', ':Neotree float reveal_file=<cfile> reveal_force_cwd<CR>', desc = 'NeoTree float reveal file', silent = true },
    { '<leader>nb', ':Neotree toggle show buffers right<CR>', desc = 'NeoTree toggle buffers', silent = true },
    { '<leader>ng', ':Neotree float git_status<CR>', desc = 'NeoTree git status', silent = true },
  },
  ---@module 'neo-tree'
  ---@type neotree.Config
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
