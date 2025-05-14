return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    vim.keymap.set('n', '<leader>pp', function()
      require('spectre').toggle()
    end, { desc = 'Toggle Spectre' })

    vim.keymap.set('n', '<leader>pw', function()
      require('spectre').open_visual { select_word = true }
    end, { desc = 'Search Word in S[P]ectre' })

    vim.keymap.set('v', '<leader>ps', function()
      require('spectre').open_visual()
    end, { desc = 'Search Selection in S[P]ectre' })
  end,
}
