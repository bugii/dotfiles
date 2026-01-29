local function load_json_with_comments(filepath)
  local file = assert(io.open(filepath, "r"))
  local content = file:read("*a")
  file:close()

  -- Remove /* ... */ block comments
  content = content:gsub("/%*.-%*/", "")
  -- Remove // line comments
  content = content:gsub("//[^\n]*", "")

  -- Parse as JSON
  local ok, result = pcall(vim.json.decode, content)
  if not ok then error("Failed to parse JSON: " .. tostring(result)) end
  return result
end

-- NOTE: this is just DG specific because they use the vscode extension which sets this info in the .vscode settings file
local function get_optional_relay_config_path(root_dir)
  -- Search for .vscode/settings.json upward from root_dir
  local settings_path = vim.fs.find(".vscode/settings.json", {
    path = root_dir,
    upward = true,
  })[1]

  if not settings_path then return nil end

  local json = load_json_with_comments(settings_path)

  return json["relay.pathToConfig"] or nil
end

local function get_relay_binary_path(root_dir)
  -- hard coded because mac is best anyways ;D
  local platform = "macos-arm64"
  return root_dir .. "/node_modules/relay-compiler/" .. platform .. "/relay"
end

local function build_relay_args(relay_binary, root_dir)
  local args = { relay_binary, "lsp", "--output=quiet-with-errors" }

  local vscode_config = get_optional_relay_config_path(root_dir)
  if vscode_config then table.insert(args, vscode_config) end

  return args
end

local function build_relay_command(relay_binary, root_dir) return build_relay_args(relay_binary, root_dir) end

vim.lsp.config.relay_lsp = {
  cmd = function(dispatchers, config)
    local root_dir = config.root_dir
    local relay_binary = get_relay_binary_path(root_dir)
    return vim.lsp.rpc.start(build_relay_command(relay_binary, root_dir), dispatchers)
  end,
  filetypes = { "typescript", "typescriptreact" },
  root_dir = function(bufnr, on_dir)
    -- we can't use package.json because it would chose a submodule
    local root = vim.fs.root(bufnr, { "node_modules", ".git" })
    if not root then root = vim.fn.getcwd() end

    local relay_binary = get_relay_binary_path(root)
    if vim.fn.executable(relay_binary) ~= 1 then
      return -- Prevent LSP from starting
    end

    on_dir(root)
  end,
  settings = {},
}

vim.lsp.enable("relay_lsp")
