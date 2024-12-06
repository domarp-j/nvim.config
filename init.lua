-- #OPTIONS
-- #KEYMAPS
-- #AUTOCOMMANDS
-- #PLUGINS
-- #COLORSCHEME

-- Set <space> as the leader key.
-- :help mapleader
-- NOTE: This must happen before plugins are loaded.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw on load so we can use Neotree instead.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--------------------------------------------------------------------------------
-- [[ #OPTIONS ]]
-- :help vim.opt
-- :help option-list
--------------------------------------------------------------------------------

vim.opt.number = true
-- vim.opt.relativenumber = true

-- Enable mouse mode. Useful for resizing splits.
-- Disable to become a keyboard master, uncoupled from the tyranny of the mouse.
-- vim.opt.mouse = 'a'

-- Hide the mode, since it's already in the status line.
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- Remove this option if you want your OS clipboard to remain independent.
-- :help 'clipboard'
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indents.
-- When enabled, it preserves the indentation of a line when it wraps
-- to the next line.
vim.opt.breakindent = true

-- Save undo history.
vim.opt.undofile = true

-- Make search case-insensitive unless using \C or 1+ capital letters in the search term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

-- Configure how new splits should be opened.
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Set how neovim displays certain whitespace characters in the editor.
-- :help 'list'
-- :help 'listchars'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type.
vim.opt.inccommand = 'split'

-- Show which line your cursor is on.
vim.opt.cursorline = true

-- Set the minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

--------------------------------------------------------------------------------
-- [[ #KEYMAPS ]]
-- :help vim.keymap.set()
--------------------------------------------------------------------------------

-- Clear highlights on search when pressing <Esc> in normal mode.
-- :help hlsearch
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- The following keybinds make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
-- :help wincmd
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Exit insert mode' })

-- Show the filesystem tree via Neotree.
-- NOTE: Make sure neo-tree is installed!
vim.keymap.set('n', 'tt', ':Neotree action=show source=filesystem toggle<CR>', { desc = 'Toggle Neotree', noremap = true, silent = true })

--------------------------------------------------------------------------------
-- [[ #AUTOCOMMANDS ]]
-- :help lua-guide-autocommands
--------------------------------------------------------------------------------

-- Highlight when yanking (copying) text.
-- :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Load Neotree instead of netrw when opening a directory.
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then
      return
    end
    vim.cmd.cd(data.file)
    require('neo-tree.command').execute { toggle = true, dir = data.file }
  end,
})

-- Add exactly one newline at end of files.
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    while #lines > 1 and lines[#lines] == '' do
      table.remove(lines)
    end
    if lines[#lines] ~= '' then
      table.insert(lines, '')
    end
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  end,
})

-- Add spellcheck and readability to READMEs.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.md',
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    vim.opt_local.linebreak = true
    vim.opt_local.wrap = true
    vim.opt_local.breakindent = true
  end,
})

--------------------------------------------------------------------------------
-- [[ #PLUGINS ]]
-- This config uses lazy.nvim to manage plugins.
-- :Lazy - See current status of plugins
-- :help lazy.nvim.txt
-- :help lazy.nvim-🔌-plugin-spec`
-- See https://github.com/folke/lazy.nvim for more.
--------------------------------------------------------------------------------

--- NOTE: Use `opts = {}` to force a plugin to be loaded.

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- vim-sleuth
  -- Automatically adjusts 'shiftwidth' and 'expandtab' heuristically based on the current file,
  -- or, in the case the current file is new, blank, or otherwise insufficient, by looking at other files
  -- of the same type in the current and parent directories.
  'tpope/vim-sleuth',

  -- conform.nvim
  -- Autoformatter
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
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },

  -- nvim-cmp
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- TODO: Read :help ins-completion
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          ['<C-y>'] = cmp.mapping.confirm { select = true },

          ['<C-Space>'] = cmp.mapping.complete {},

          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          {
            name = 'lazydev',
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  -- todo-comments.nvim
  -- Highlight comments with prefixes like TODO, NOTE, WARN, HACK, and more!
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = { signs = false },
  },

  -- mini.nvim
  -- A collection of small but extremely useful plugins and modules
  -- See https://github.com/echasnovski/mini.nvim
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      local statusline = require 'mini.statusline'
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- nvim-treesitter
  -- Unlike the LSP, treesitter does code highlighting, editing, and navigation effectively
  -- at the file level as opposed to the project level.
  -- See :help lsp-vs-treesitter for more details.
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  --
  { import = 'plugins' },
}, {
  ui = {
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
