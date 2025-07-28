return {
  'folke/tokyonight.nvim',
  lazy = false, -- make sure the colorscheme is loaded first
  priority = 1000, -- make sure to load this before all the other start plugins
  opts = {}, -- table of options for tokyonight
  config = function()
    -- load the colorscheme here
    vim.cmd.colorscheme 'tokyonight'
  end,
}
