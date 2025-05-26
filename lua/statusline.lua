-- Shorthands for vim fields
local api = vim.api
local fn = vim.fn
-- Set vim so it does not show the mode below the statusline since the statusline will show the mode.
vim.o.showmode = false

-- TODO: Make statusline refresh the LSP on change
-- TODO: Show mode only in the statusline not below it
-- TODO: Fix how statusline truncates
-- TODO: Move the separators into an external file so I can reuse them
-- TODO: I want to also include the current directory
-- TODO: Don't show git if there is no remote?
-- TODO: Color gitsigns and lsp symbols
-- NOTE: Use  and other symbols for the tabline and neo-tree once I set that up

--- LSP Diagnostics Severity Levels
local lsp_levels = {
  ERROR = 1,
  WARN = 2,
  INFO = 3,
  HINT = 4,
}

local M = {}

M.trunc_width = setmetatable({
  mode = 80,
  git_status = 90,
  line_col = 60,
  lsp_stats = 80,
}, {
  __index = function()
    return 80
  end,
})

--- Separators the statusline will use
M.separators = {
  -- FIXME: The half circle has a different radius than the arc
  half_circle = { left = '', right = '' },
  arc = { left = '', right = '' },
  arrow = { left = '', right = '' },
  chevron = { left = '󰅂', right = '󰅁' },
  dots = { left = '󰃌', right = '󰃏' },
  flame = { left = '', right = '' },
  -- = { left = '', right = '' },
  blank = { '', '' },
}

---Editing modes the statusline can display
M.modes = setmetatable({
  ['n'] = { hl = '%#ModeNormal#', sep = '%#ModeNormalSep#', full = 'Normal', short = 'N' },
  ['no'] = { hl = '%#ModeNormal#', sep = '%#ModeNormalSep#', full = 'Normal', short = 'N' },
  ['v'] = { hl = '%#ModeVisual#', sep = '%#ModeVisualSep#', full = 'Visual', shot = 'V' },
  ['V'] = { hl = '%#ModeVisual#', sep = '%#ModeVisualSep#', full = 'Visual Line', short = 'VL' },
  [''] = { hl = '%#ModeVisual#', sep = '%#ModeVisualSep#', full = 'Visual Block', short = 'VB' },
  ['s'] = { hl = '%#ModeSelect#', sep = '%#ModeSelectSep#', full = 'Select', short = 'S' },
  ['S'] = { hl = '%#ModeSelect#', sep = '%#ModeSelectSep#', full = 'Select Line', short = 'SL' },
  [''] = { hl = '%#ModeSelect#', sep = '%#ModeSelectSep#', full = 'Select Block', short = 'SB' },
  ['i'] = { hl = '%#ModeInsert#', sep = '%#ModeInsertSep#', full = 'Insert', short = 'IN' },
  ['ic'] = { hl = '%#ModeInsert#', sep = '%#ModeInsertSep#', 'Insert', 'IN' },
  ['R'] = { hl = '%#ModeReplace#', sep = '%#ModeReplaceSep#', full = 'Replace', short = 'R' },
  ['Rv'] = { hl = '%#ModeReplace#', sep = '%#ModeReplaceSep#', full = 'Visual Replace', short = 'VR' },
  ['c'] = { hl = '%#ModeCommand#', sep = '%#ModeCommandSep#', full = 'Command', short = 'C' },
  ['cv'] = { hl = '%#ModeEx#', sep = '%#ModeExSep#', full = 'Vim Ex', short = 'VE' },
  ['ce'] = { hl = '%#ModeEx#', sep = '%#ModeExSep#', full = 'Ex', short = 'Ex' },
  ['r'] = { hl = '%#ModePrompt#', sep = '%#ModePromptSep#', full = 'Prompt', short = 'P' },
  ['rm'] = { hl = '%#ModeMore#', sep = '%#ModeMoreSep#', full = 'More', short = 'M' },
  ['r?'] = { hl = '%#ModeConfirm#', sep = '%#ModeConfirmSep#', full = 'Confirm', short = 'C' },
  ['!'] = { hl = '%#ModeShell#', sep = '%#ModeShellSep#', full = 'Shell', short = 'S' },
  ['t'] = { hl = '%#ModeTerm#', sep = '%#ModeTermSep#', full = 'Terminal', short = 'T' },
}, {
  __index = function()
    return { hl = '', sep = '', full = 'Unknown', short = 'Un' }
  end,
})

--- Define the colors the status line will use
M.colors = {}

--- Return true if the current window is smaller than the size of content passed in to it.
function M.is_truncated(width)
  local current_width = api.nvim_win_get_width(0)
  return current_width < width
end

function M:mode()
  local current = vim.api.nvim_get_mode().mode
  -- Return the abridged mode notation if the statusline is truncated
  if self.is_truncated(self.trunc_width.mode) then
    return string.format('%s%s%s', self.modes[current].hl, self.modes[current].short, self.modes[current].sep)
  end
  -- Otherwise return the full mode
  return string.format('%s%s%s', self.modes[current].hl, self.modes[current].full, self.modes[current].sep)
end

-- I want to know
function M:git_status()
  -- Use fallback because it doesn't set this variable on the initial `BufEnter`
  local signs = vim.b.gitsigns_status_dict or { head = '', added = '', changed = '', removed = '' }
  --true if there is no head empty
  local no_head = signs.head == ''

  -- Return the abridged git info if the statusline is truncated
  if self.is_truncated(self.trunc_width.git_status) then
    return not no_head and string.format(' %s ', signs.head or '') or ''
  end

  -- Otherwise return the full git status
  return string.format('  %s %s %s %s', signs.head, signs.added, signs.changed, signs.removed) or ''
end

function M:line_info()
  if self.is_truncated(self.trunc_width.line_col) then
    return ''
  end
  -- If the document percentage would show 'Bot' or 'All' show 100%
  -- This goes before the top one so a document that fits on the screen shows 100%
  if fn.line 'w$' == fn.line '$' then
    return 'Ln:%l, Col:%c 100%%'
  end

  -- If the document percentage would show 'Top' show 0% instead
  if fn.line 'w0' == 1 then
    return 'Ln:%l, Col:%c 0%%'
  end
  -- These are built into the statusline
  return 'Ln:%l, Col:%c %P'
end

function M:lspinfo()
  local count = {
    ERROR = vim.diagnostic.severity.ERROR,
    WARN = vim.diagnostic.severity.WARN,
    HINT = vim.diagnostic.severity.HINT,
    INFO = vim.diagnostic.severity.INFO,
  }

  if self.is_truncated(self.trunc_width.lsp_stats) then
    return ''
  end

  local errors = ''
  local warnings = ''
  local hints = ''
  local info = ''

  if count['ERROR'] ~= 0 then
    errors = '' .. ' ' .. count['ERROR']
  end
  if count['WARN'] ~= 0 then
    warnings = '' .. ' ' .. count['WARN']
  end
  if count['HINT'] ~= 0 then
    hints = '' .. ' ' .. count['HINT']
  end
  if count['INFO'] ~= 0 then
    info = '' .. ' ' .. count['INFO']
  end

  return errors .. ' ' .. warnings .. ' ' .. hints .. ' ' .. info
end

function M:draw_active()
  return self:mode()
    .. self.separators.half_circle.left
    .. ' '
    .. '%#GitStatus#'
    .. self:git_status()
    .. '%#GitStatusSep#'
    .. self.separators.half_circle.left
    .. ' '
    .. '%#LSPStatus#'
    .. self:lspinfo()
    .. '%#LSPStatusSep#'
    .. self.separators.half_circle.left
    .. '%#StatusLine#'
    .. '%='
    .. '%#PosStatus#'
    .. self:line_info()
end
-- NOTE: Autocmds can be used to update the statusline on events which would not automatically triffer a redraw

-- vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
--   callback = function()
--     vim.cmd 'redrawstatus'
--   end,
-- })

-- Definine a function in the global scope which calls evaluates the response of loading statusline.lua and calling `draw_active`
function _G.my_statusline()
  return M:draw_active()
end

vim.o.statusline = '%!v:lua.my_statusline()'
