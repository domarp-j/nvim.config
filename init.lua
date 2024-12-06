-- config-global
-- config-options
-- config-keymaps
-- config-commands
-- config-autocommands
-- config-plugins

--------------------------------------------------------------------------------
-- [[ GLOBAL CONFIGS ]] config-global
-- :help vim.opt
-- :help option-list
--------------------------------------------------------------------------------
---
-- Set <space> as the leader key.
-- :help mapleader
-- NOTE: This must happen before plugins are loaded.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable netrw on load so we can use Neotree instead.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable if you have a Nerd Font installed.
-- NOTE: A Nerd Font is required for icons to display correctly.
-- The installation for a Nerd Font depends on your OS and terminal.
vim.g.have_nerd_font = true

--------------------------------------------------------------------------------
-- [[ OPTIONS ]] config-options
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
-- [[ KEYMAPS ]] config-keymaps
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
-- NOTE: Make sure the neo-tree plugin is installed!
vim.keymap.set('n', '|', ':Neotree reveal<CR>', { silent = true, desc = 'Toggle Neotree focus' })

-- Easily navigate errors within a file.
vim.keymap.set('n', ']e', function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end)
vim.keymap.set('n', '[e', function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end)

--------------------------------------------------------------------------------
-- [[ COMMANDS ]] config-commands
-- :help lua-guide-commands
--------------------------------------------------------------------------------

-- ...none yet...

--------------------------------------------------------------------------------
-- [[ AUTOCOMMANDS ]] config-autocommands
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
-- [[ PLUGINS ]] config-plugins
-- This config uses lazy.nvim to manage plugins.
-- All installed plugins can be found in the ./lua/plugins/ dir.
-- :Lazy - See current status of plugins
-- :help lazy.nvim.txt
-- :help lazy.nvim-🔌-plugin-spec`
-- See https://github.com/folke/lazy.nvim for more.
-- NOTE: Use `opts = {}` to force a plugin to be loaded.
--------------------------------------------------------------------------------

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
  { import = 'plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
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
