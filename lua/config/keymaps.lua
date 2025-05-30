-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('n', '<Esc><Esc>', function()
  print 'working'
end, { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- External Keybinds I find comfy
-- Undo
vim.keymap.set({ 'n', 'v', 'i' }, '<C-z>', function()
  vim.cmd 'undo'
end, { desc = 'Undo last action' })

-- Redo
vim.keymap.set({ 'n', 'v' }, '<C-y>', function()
  vim.cmd 'redo'
end, { desc = 'Redo last action' })

-- Select all
vim.keymap.set({ 'n', 'v' }, '<C-a>', '<Esc>ggVG')

-- Save
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', function()
  vim.cmd 'write'
end, { desc = 'Save current file' })
