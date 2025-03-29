vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*",
	callback = function ()
		vim.fn.append(0, {
			"public class " ..vim.fn.expand("%:t:r") .. " {",
			"	public static void main (String[] args) {",
			"		System.out.println(\"Hello Na-chan\");",
			"	}",
			"}"
		})
		vim.cmd("normal! G")
	end,
})
