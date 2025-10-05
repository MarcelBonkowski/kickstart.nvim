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
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Flutter Development Keymaps
vim.keymap.set('n', '<leader>fr', ':FlutterRun<CR>', { desc = 'Flutter Run' })
vim.keymap.set('n', '<leader>fq', ':FlutterQuit<CR>', { desc = 'Flutter Quit' })
vim.keymap.set('n', '<leader>fh', ':FlutterHotReload<CR>', { desc = 'Flutter Hot Reload' })
vim.keymap.set('n', '<leader>fR', ':FlutterRestart<CR>', { desc = 'Flutter Restart' })
vim.keymap.set('n', '<leader>fd', ':FlutterDevices<CR>', { desc = 'Flutter Devices' })
vim.keymap.set('n', '<leader>fe', ':FlutterEmulators<CR>', { desc = 'Flutter Emulators' })
vim.keymap.set('n', '<leader>fo', ':FlutterOutlineToggle<CR>', { desc = 'Flutter Outline Toggle' })
vim.keymap.set('n', '<leader>ft', ':FlutterDevTools<CR>', { desc = 'Flutter DevTools' })
vim.keymap.set('n', '<leader>fl', ':FlutterLogClear<CR>', { desc = 'Flutter Log Clear' })
vim.keymap.set('n', '<leader>fp', ':PubspecAssistAddDependency<CR>', { desc = 'Add Dependency' })