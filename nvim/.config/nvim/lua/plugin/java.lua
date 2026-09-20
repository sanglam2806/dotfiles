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

      local java_home = "/opt/homebrew/opt/openjdk@25"

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
