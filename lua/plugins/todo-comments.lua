-- todo-comments.nvim
-- Highlights special comment keywords (TODO, FIXME, NOTE, HACK, WARN, PERF) in a distinct color throughout the codebase.

return {
  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    ---@module 'todo-comments'
    ---@type TodoOptions
    ---@diagnostic disable-next-line: missing-fields
    opts = { signs = false },
  },
}
