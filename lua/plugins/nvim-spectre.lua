return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Spectre setup with hidden files enabled, ignoring .git and node_modules
    require('spectre').setup {
      find_engine = {
        ['rg'] = {
          cmd = 'rg',
          args = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--hidden', -- include hidden files
            '--glob',
            '!.git/*', -- skip .git
            '--glob',
            '!node_modules/*', -- skip node_modules
          },
          options = {
            ['ignore-case'] = {
              value = '--ignore-case',
              icon = '[I]',
              desc = 'ignore case',
            },
            ['hidden'] = {
              value = '--hidden',
              icon = '[H]',
              desc = 'hidden files',
            },
          },
        },
      },
    }

    -- Keymaps
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
