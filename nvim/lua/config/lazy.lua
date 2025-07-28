local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--vim.api.nvim_set_hl(0, 'Normal', { bg = '#0f0f0f' })

-- Force a custom background color after any colorscheme loads
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*', -- Matches every colorscheme
  callback = function()
    -- This overrides the 'Normal' group set by the colorscheme
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#0f0f0f' })

    -- Optional: If you want non-active windows to have the same background
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#0f0f0f' })
  end,
})

require("lazy").setup({
	spec = {
		{import="plugins"}
	},
	checker = { enabled = false },
})
