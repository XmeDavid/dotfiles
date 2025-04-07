-- [NVIM] leader -- <space>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- [NVIM DEFAULTS] :e <filename> — Open a file
-- [NVIM DEFAULTS] :bnext / :bprev — Switch between open buffers
-- [NVIM DEFAULTS] :ls or :buffers — List open buffers
-- [NVIM DEFAULTS] :bd — Delete a buffer (close file)
-- [NVIM DEFAULTS] gf — Go to file under cursor (if it's a path)

-- [TELESCOPE] find files (default) -- fs
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
-- [TELESCOPE] find files (git) -- fS
vim.keymap.set("n", "<leader>fS", function()
  local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
  if not ok then
    require("telescope.builtin").find_files({ hidden = true })
  end
end, { desc = "Find files in Git project (fallback to all files)" })
-- [TELESCOPE] find files (all) -- fa
vim.keymap.set("n", "<leader>fa", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Find all files (including hidden)" })
-- [TELESCOPE] search (default) -- fw
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
-- [TELESCOPE] search (all) -- fW
vim.keymap.set("n", "<leader>fW", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden", "--no-ignore" }
    end,
  })
end, { desc = "Live grep including hidden files" })
-- [TELESCOPE] search (git) -- fg
vim.keymap.set("n", "<leader>fg", function()
  local ok, files = pcall(vim.fn.systemlist, "git ls-files")
  if ok and #files > 0 then
    require("telescope.builtin").live_grep({ search_dirs = files })
  else
    require("telescope.builtin").live_grep({ hidden = true, additional_args = function() return { "--no-ignore" } end })
  end
end, { desc = "Live grep in Git project (fallback to full search)" })
-- [TELESCOPE] view git commits -- gc
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "View Git commits" })
-- [TELESCOPE] recent files -- fo
vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Open recent file" })
-- [TELESCOPE] last telescope search -- ff
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope resume<CR>", { desc = "Resume last Telescope search" })
-- [TELESCOPE] open buffers -- fb
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List open buffers" })
-- [TELESCOPE] telescope help -- fh
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Search help" })
-- [TELESCOPE] grep for current word -- fc
vim.keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").grep_string()
end, { desc = "Grep for word under cursor" })
