return {
  -- lazydev.nvim
  -- Configure the Lua LSP for your Neovim config, runtime, and plugins.
  --
  -- NOTE: LSP = Language Server Protocol.
  -- LSPs help editors and language tooling communicate in a standardized fashion.
  -- In general, you have a *server*, which is some tool built to understand a particular language,
  -- such as gopls, lua_ls, rust_analyzer, and so on.
  -- The *client* in this case is Neovim.
  -- Some LSP features include:
  -- - Go to definition
  -- - Find references
  -- - Autocompletion
  -- - Symbol search
  -- - And more!
  --
  -- NOTE: LSPs are not the same as treesitters.
  -- :help lsp-vs-treesitter
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
}
