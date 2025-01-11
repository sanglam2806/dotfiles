function LSPMapping()
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
	vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
	vim.keymap.set("n", "<C-space>", vim.lsp.buf.completion, {})
	
	-- show all function in current file
	vim.keymap.set("n","<leader>fm", function()
		local file_type = vim.bo.filetype
		local symbol_map = {
			java = "function",
			lua = "function",
			go = {"method", "struct", "interface"},
		}
		local symbol = symbol_map[file_type] or "function"
		require("telescope.builtin").lsp_document_symbols({ symbols = symbol })
	end, {})

end

LSPMapping()
