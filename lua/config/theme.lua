return {
  -- Use `:Telescope colorscheme` to see installed themes.
  'catppuccin/nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  name = 'catppuccin',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('catppuccin').setup {
      flavour = 'mocha',
      color_overrides = {},
    }

    -- Load the colorscheme.
    vim.cmd.colorscheme 'catppuccin'
  end,
}
