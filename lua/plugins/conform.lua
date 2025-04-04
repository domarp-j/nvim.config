-- Autoformat
-- NOTE: This plugin requires installation of any desired formatters,
-- such as eslint_d or prettierd. Update `ensure_installed` in
-- nvim-lspconfig.lua so that Mason installs them automatically.
return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 5000,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        css = { 'eslint_d', 'prettierd' },
        javascript = { 'eslint_d', 'prettierd' },
        javascriptreact = { 'eslint_d', 'prettierd' },
        lua = { 'stylua' },
        typescript = { 'eslint_d', 'prettierd' },
        typescriptreact = { 'eslint_d', 'prettierd' },
      },
    },
  },
}
