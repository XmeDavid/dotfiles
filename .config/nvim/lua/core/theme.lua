require("rose-pine").setup({
  variant = "moon", -- options: 'main' | 'moon' | 'dawn'
  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },
})

vim.cmd("colorscheme rose-pine")

