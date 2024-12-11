-- Faster alternative to typescript-language-server

return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    local lspconfig = require 'lspconfig'
    require('typescript-tools').setup {
      single_file_support = false,
      root_dir = lspconfig.util.root_pattern 'package.json',
    }
  end,
}
