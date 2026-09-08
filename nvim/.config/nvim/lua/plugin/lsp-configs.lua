return {
    {
        "williamboman/mason.nvim",
        config = function()
        	require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"zls",
					--"gopls",
					-- "jdtls",
					"pyright",
				}
			})
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- local lspconfig = require("lspconfig")

            -- lua
            vim.lsp.config['lua_ls'] = {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }

			--zig
			vim.lsp.config['zls'] = {
				capabilities = capabilities,
				root_markers = {".git", {"build.zig", "zls.json"}},
				settings = {
					zls = {
						enable_inlay_hints = false,
						enable_snippets = true,
						warn_style = true,
					},
				}
			}

			vim.g.zig_fmt_parse_errors = 0
			vim.g.zig_fmt_autosave = 0

			-- --Java
			-- lspconfig.jdtls.setup({
			-- 	settings = {
			-- 		java = {
			-- 			configuration = {
			-- 				runtimes = {
			-- 					{
			-- 						name = "JavaSE-23",
			-- 						path = "/opt/jdk-23",
			-- 						default = true,
			-- 					},
			-- 				},
			-- 			},
			-- 		},
			-- 	},
			-- })

			--GoLang
			vim.lsp.config['gopls'] = {
				capabilities = capabilities,
			}

			--python
			vim.lsp.config['pyright']={
				capabilities = capabilities,
			}

        end,
    },
}
