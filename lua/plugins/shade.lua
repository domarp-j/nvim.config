-- Make it easier to see which the active window

return {
  'sunjon/shade.nvim',
  config = function()
    require('shade').setup {
      overlay_opacity = 60,
      opacity_step = 1,
      -- keys = {
      --   brightness_up = '<C-Up>',
      --   brightness_down = '<C-Down>',
      --   toggle = '<Leader>s',
      -- },
    }
  end,
}