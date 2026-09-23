return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")

      local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "settings.gradle" })
      if root_dir == "" then
        return
      end

      local project_name = vim.fn.fnamemodify(root_dir, ":t")
      local workspace_dir = vim.fn.expand("~/.local/share/nvim/jdtls-workspace/") .. project_name
      local lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar")

      -- Resolve JAVA_HOME dynamically so switching `jenv global/local` also affects jdtls.
      -- Falls back to $JAVA_HOME, then a hardcoded default if jenv isn't available.
      local function resolve_java_home()
        local jenv_bin = vim.fn.exepath("jenv")
        if jenv_bin ~= "" then
          local cmd = string.format("cd %s && %s javahome", vim.fn.shellescape(root_dir), jenv_bin)
          local result = vim.fn.trim(vim.fn.system(cmd))
          if vim.v.shell_error == 0 and result ~= "" then
            return result
          end
        end
        return os.getenv("JAVA_HOME") or "/opt/homebrew/opt/openjdk@25"
      end

      local java_home = resolve_java_home()

      local cmd = {
        "jdtls",
        "-data", workspace_dir,
        "--jvm-arg=-javaagent:" .. lombok_jar,
		"--jvm-arg=-Xbootclasspath/a:" .. lombok_jar,
      }

      jdtls.start_or_attach({
        cmd = cmd,
        cmd_env = { JAVA_HOME = java_home },
        root_dir = root_dir,
        settings = {
          java = {
            import = {
              gradle = {
                java = {
                  home = java_home,
                },
              },
            },
          },
        },
      })
    end,
  },
}
