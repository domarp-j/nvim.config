-- Collection of plugins to interact with databases within Neovim

return {
  'tpope/vim-dadbod',
  {
    'kristijanhusak/vim-dadbod-ui',
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font and 1 or 0

      -- Increase the size of the drawer
      vim.g.db_ui_winwidth = 70
    end,
  },
  'kristijanhusak/vim-dadbod-completion', -- NOTE: Requires further setup in nvim-cmp
}
