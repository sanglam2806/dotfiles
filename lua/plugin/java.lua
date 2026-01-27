return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")

      local lombok_jar = vim.fn.expand("~/.local/share/java/lombok.jar")

      local cmd = {
        "jdtls",
        "--jvm-arg=-javaagent:" .. lombok_jar,
      }

      jdtls.start_or_attach({
        cmd = cmd,
      })
    end,
  },
}
