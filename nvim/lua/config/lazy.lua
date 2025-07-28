local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_hl(0, 'Normal', { bg = '#0f0f0f' })
local colors = {
    bg = '#0f0f0f',
    fg = '#acb0be',
    fg_dim = '#9ca0b0',
    muted = '#5c5f77',
    dim = '#6c6f85',
    red = '#d20f39',
    green = '#40a02b',
    yellow = '#df8e1d',
    blue = '#1e66f5',
    magenta = '#8839ef',
    cyan = '#179299',
}
-- Treesitter
vim.api.nvim_set_hl(0, '@comment', { link = 'Comment' })
vim.api.nvim_set_hl(0, '@keyword', { link = 'Keyword' })
vim.api.nvim_set_hl(0, '@keyword.function', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@keyword.operator', { fg = colors.magenta })
vim.api.nvim_set_hl(0, '@keyword.return', { fg = colors.magenta })
vim.api.nvim_set_hl(0, '@string', { link = 'String' })
vim.api.nvim_set_hl(0, '@number', { link = 'Number' })
vim.api.nvim_set_hl(0, '@boolean', { link = 'Boolean' })
vim.api.nvim_set_hl(0, '@float', { link = 'Float' })
vim.api.nvim_set_hl(0, '@function', { link = 'Function' })
vim.api.nvim_set_hl(0, '@function.builtin', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@function.call', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@function.macro', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@method', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@method.call', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@constructor', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@parameter', { fg = colors.red })
vim.api.nvim_set_hl(0, '@variable', { fg = colors.fg })
vim.api.nvim_set_hl(0, '@variable.builtin', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@constant', { link = 'Constant' })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = colors.yellow })
vim.api.nvim_set_hl(0, '@constant.macro', { fg = colors.yellow })
vim.api.nvim_set_hl(0, '@type', { link = 'Type' })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@type.definition', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@type.qualifier', { fg = colors.magenta })
vim.api.nvim_set_hl(0, '@attribute', { fg = colors.yellow })
vim.api.nvim_set_hl(0, '@property', { fg = colors.green })
vim.api.nvim_set_hl(0, '@operator', { link = 'Operator' })
vim.api.nvim_set_hl(0, '@punctuation', { fg = colors.muted })
vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = colors.fg_dim })
vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = colors.muted })
vim.api.nvim_set_hl(0, '@punctuation.special', { fg = colors.yellow })
vim.api.nvim_set_hl(0, '@tag', { fg = colors.red })
vim.api.nvim_set_hl(0, '@tag.attribute', { fg = colors.green })
vim.api.nvim_set_hl(0, '@tag.delimiter', { fg = colors.muted })
vim.api.nvim_set_hl(0, '@label', { fg = colors.red })
vim.api.nvim_set_hl(0, '@namespace', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@include', { link = 'Include' })
vim.api.nvim_set_hl(0, '@error', { fg = colors.red })
vim.api.nvim_set_hl(0, '@todo', { link = 'Todo' })
vim.api.nvim_set_hl(0, '@text', { fg = colors.fg })
vim.api.nvim_set_hl(0, '@text.literal', { fg = colors.green })
vim.api.nvim_set_hl(0, '@text.reference', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@text.title', { fg = colors.magenta, bold = true })
vim.api.nvim_set_hl(0, '@text.uri', { fg = colors.blue, underline = true })
vim.api.nvim_set_hl(0, '@text.underline', { underline = true })
vim.api.nvim_set_hl(0, '@text.todo', { bg = colors.yellow, fg = colors.bg })

require("lazy").setup({
	spec = {
		{import="plugins"}
	},
	checker = { enabled = false },
})
