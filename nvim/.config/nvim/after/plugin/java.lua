local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/nvim/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
    return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities
--
-- detect OS
local os_config = ""
if vim.fn.has("mac") == 1 then
    os_config = "config_mac"
elseif vim.fn.has("unix") == 1 then
    os_config = "config_linux"
elseif vim.fn.has("win32") == 1 then
    os_config = "config_win"
end

local root_dir = require("jdtls.setup").find_root({
    ".git",
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
    "settings.gradle",
})

-- resolve the JDK selected by jenv for this project (.java-version / global)
local function java_major(java_home)
    local f = io.open(java_home .. "/release", "r")
    if not f then
        return nil
    end
    local version = f:read("*a"):match('JAVA_VERSION="([^"]+)"')
    f:close()
    return version and tonumber(version:match("^(%d+)"))
end

local jenv = vim.system({ "jenv", "prefix" }, { cwd = root_dir or vim.fn.getcwd(), text = true }):wait()
local java_home = jenv.code == 0 and vim.trim(jenv.stdout) or os.getenv("JAVA_HOME")
local major = java_home and java_major(java_home)

-- jdtls itself needs Java 21+; older JDKs are still used to compile the project
local fallback_java_home = "/opt/homebrew/opt/openjdk@25/libexec/openjdk.jdk/Contents/Home"
local jdtls_java_home = (major and major >= 21) and java_home or fallback_java_home

local runtimes = {}
if java_home and major then
    table.insert(runtimes, { name = "JavaSE-" .. (major <= 8 and "1." .. major or major), path = java_home, default = true })
end

local config = {
    cmd = {
        jdtls_java_home .. "/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        "-jar",
        vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        home .. "/.local/share/nvim/mason/packages/jdtls/" .. os_config,
        "-data",
        workspace_dir,
    },
    root_dir = root_dir,

    settings = {
        java = {
            configuration = {
                runtimes = runtimes,
            },
            signatureHelp = { enabled = true },
            extendedClientCapabilities = extendedClientCapabilities,
            maven = {
                downloadSources = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            inlayHints = {
                parameterNames = {
                    enabled = "all", -- literals, all, none
                },
            },
            format = {
                enabled = true,
                settings = {
                    profile = "GoogleStyle",
                },
            },
        },
    },

    init_options = {
        bundles = {},
    },
}
require("jdtls").start_or_attach(config)

vim.keymap.set("n", "<leader>co", "<Cmd>lua require'jdtls'.organize_imports()<CR>", { desc = "Organize Imports" })
vim.keymap.set("n", "<leader>crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", { desc = "Extract Variable" })
vim.keymap.set(
    "v",
    "<leader>crv",
    "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
    { desc = "Extract Variable" }
)
vim.keymap.set("n", "<leader>crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", { desc = "Extract Constant" })
vim.keymap.set(
    "v",
    "<leader>crc",
    "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
    { desc = "Extract Constant" }
)
vim.keymap.set(
    "v",
    "<leader>crm",
    "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
    { desc = "Extract Method" }
)
