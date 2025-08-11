-- Powerful file navigation

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = false,
      window = {
        position = 'current',
      },
      filesystem = {
        filtered_items = {
          visible = true, -- 👈 show hidden files by default
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    }
  end,
}
