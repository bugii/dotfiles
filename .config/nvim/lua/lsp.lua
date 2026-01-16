local function get_optional_relay_config_path(root_dir)
  -- Search for .vscode/settings.json upward from root_dir
  local settings_path = vim.fs.find(".vscode/settings.json", {
    path = root_dir,
    upward = true,
  })[1]

  if not settings_path then return nil end

  local ok, content = pcall(vim.fn.readfile, settings_path)
  if not ok then return nil end

  local json = vim.json.decode(table.concat(content))

  return json["relay.pathToConfig"] or nil
end

local function build_relay_args(relay_binary, root_dir)
  local args = { relay_binary, "lsp", "--output=quiet-with-errors" }

  local vscode_config = get_optional_relay_config_path(root_dir)
  if vscode_config then table.insert(args, vscode_config) end

  return args
end

local function build_relay_command(root_dir)
  local platform = "macos-arm64"
  local local_relay = root_dir .. "/node_modules/relay-compiler/" .. platform .. "/relay"

  return build_relay_args(local_relay, root_dir)
end

vim.lsp.config.relay_lsp = {
  cmd = function(dispatchers, config)
    local root_dir = config.root_dir or vim.fn.getcwd()

    return vim.lsp.rpc.start(build_relay_command(root_dir), dispatchers)
  end,
  filetypes = { "typescript", "typescriptreact" },
  root_dir = function(bufnr, on_dir)
    -- we can't use package.json because it would chose a submodule
    local root = vim.fs.root(bufnr, { "node_modules", ".git" })
    if root then
      on_dir(root)
    else
      on_dir(vim.fn.getcwd())
    end
  end,
  settings = {},
}

vim.lsp.enable("relay_lsp")
