vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List open buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Search help" })

vim.keymap.set("n", "<leader>fa", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
end, { desc = "Find all files (including hidden)" })

vim.keymap.set("n", "<leader>fG", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden", "--no-ignore" }
    end,
  })
end, { desc = "Live grep including hidden files" })
