return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")

      local lombok_jar = vim.fn.expand("~/.local/share/nvim/mason/packages/jdtls/lombok.jar")

      local cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. lombok_jar,
		"--jvm-arg=-Xbootclasspath/a:" .. lombok_jar,
      }

      jdtls.start_or_attach({
        cmd = cmd,
      })
    end,
  },
}
