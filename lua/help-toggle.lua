vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	callback = function ()
		local currentBuff = vim.api.nvim_get_current_buf();
		local config = {
			relative = "editor",
			width = math.floor(vim.o.columns * 0.7),
			height = math.floor(vim.o.lines * 0.7),
			row = math.floor( vim.o.lines *0.1 ),
			col = math.floor( vim.o.columns * 0.1 ),
			border = "rounded"
		};
		vim.cmd("wincmd c")
			vim.api.nvim_open_win(currentBuff, true, config);
	end,
});
