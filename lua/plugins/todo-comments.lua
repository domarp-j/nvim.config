-- Highlight comments with prefixes like TODO, NOTE, WARN, HACK, and more

return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = { signs = false },
}
