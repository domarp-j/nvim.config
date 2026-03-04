-- vim-dadbod
-- Database client for Neovim. Browse connections and schemas via :DBUIToggle, run queries in SQL buffers, and get SQL autocompletion through blink-cmp.

return {
  'tpope/vim-dadbod',
  dependencies = {
    {
      'kristijanhusak/vim-dadbod-ui',
      cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
      keys = {
        { '<leader>db', '<cmd>DBUIToggle<cr>', desc = 'Toggle DB UI' },
      },
      init = function()
        vim.g.db_ui_use_nerd_fonts = vim.g.have_nerd_font and 1 or 0
      end,
    },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
    },
  },
}
