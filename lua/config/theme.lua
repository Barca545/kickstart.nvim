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
      highlight_overrides = {
        --Define custom highlight groups for the statusline
        mocha = function(mocha)
          local nomal_mode_bg = mocha.green
          local insert_mode_bg = mocha.sapphire
          local cmd_mode_bg = mocha.peach
          local visual_mode_bg = mocha.mauve
          local git_status_bg = mocha.lavender
          local lsp_status_bg = mocha.text
          local statusline_bg = mocha.crust
          local txtclr = mocha.base

          return {
            StatusLine = { bg = statusline_bg },
            ModeNormal = { fg = txtclr, bg = nomal_mode_bg },
            ModeNormalSep = { fg = nomal_mode_bg, bg = git_status_bg },
            ModeInsert = { fg = txtclr, bg = insert_mode_bg },
            ModeInsertSep = { fg = insert_mode_bg, bg = git_status_bg },
            ModeCommand = { fg = txtclr, bg = cmd_mode_bg },
            ModeCommandSep = { fg = cmd_mode_bg, bg = git_status_bg },
            ModeVisual = { fg = txtclr, bg = visual_mode_bg },
            ModeVisualSep = { fg = visual_mode_bg, bg = git_status_bg },
            GitStatus = { fg = txtclr, bg = git_status_bg },
            GitStatusSep = { fg = git_status_bg, bg = lsp_status_bg },
            LSPStatus = { fg = txtclr, bg = lsp_status_bg },
            LSPStatusSep = { fg = lsp_status_bg, bg = statusline_bg },
            PosStatus = { fg = txtclr, bg = mocha.blue },
          }
        end,
      },
    }
    -- Load the colorscheme.
    vim.cmd.colorscheme 'catppuccin'
  end,
}
