local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
-- vim.o.termguicolors = false
vim.opt.background = "dark"
--
vim.opt.cursorline = true
-- vim.api.nvim_set_hl(0, "Visual", {
--   ctermbg = 187,
-- })
-- vim.api.nvim_set_hl(0, "CursorLine", {
--
--   ctermbg = 180, -- light yellow
--
-- })
vim.opt.runtimepath:prepend(lazypath)

require("vim-options")
require("vim-helpers")
require("help-toggle")
require("terminal-toggle")
require("java-init")
require("remap")
require("lazy").setup("plugin")
