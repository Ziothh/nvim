-- Per-project formatter selection for JS/TS and web filetypes:
--   * biome      if the project has a biome config (and biome supports the filetype)
--   * prettierd  if the project uses prettier (config file, package.json key, or local install)
--   * otherwise  return {} so conform falls back to the LSP formatter (ts_ls)
-- biome wins when a project configures both. Lua always formats with stylua.

local M = {}

local uv = vim.uv or vim.loop

-- config filenames prettier itself searches for
local prettier_cfgs = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.yaml",
  ".prettierrc.yml",
  ".prettierrc.json5",
  ".prettierrc.toml",
  ".prettierrc.js",
  ".prettierrc.cjs",
  ".prettierrc.mjs",
  ".prettierrc.ts",
  "prettier.config.js",
  "prettier.config.cjs",
  "prettier.config.mjs",
  "prettier.config.ts",
}

local biome_cfgs = { "biome.json", "biome.jsonc" }

-- filetypes biome can format (everything else only ever routes to prettier)
local biome_fts = {
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  json = true,
  jsonc = true,
  css = true,
  graphql = true,
}

local function exists(path)
  return uv.fs_stat(path) ~= nil
end

-- directory to start the upward search from
local function buf_dir(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return uv.cwd()
  end
  return vim.fs.dirname(name)
end

-- nearest matching file walking up from `dir` (handles monorepos: closest wins)
local function find_up(dir, names)
  return vim.fs.find(names, { upward = true, path = dir, type = "file" })[1]
end

local function pkg_has_prettier(pkg)
  local ok, lines = pcall(vim.fn.readfile, pkg)
  if not ok then
    return false
  end
  local decoded, json = pcall(vim.json.decode, table.concat(lines, "\n"))
  return decoded and type(json) == "table" and json.prettier ~= nil
end

local function uses_biome(dir)
  return find_up(dir, biome_cfgs) ~= nil
end

local function uses_prettier(dir)
  if find_up(dir, prettier_cfgs) then
    return true
  end
  local pkg = find_up(dir, { "package.json" })
  if pkg then
    if pkg_has_prettier(pkg) then
      return true
    end
    if exists(vim.fs.dirname(pkg) .. "/node_modules/.bin/prettier") then
      return true
    end
  end
  return false
end

--- @param bufnr integer
--- @return string[]
local function pick(bufnr)
  local dir = buf_dir(bufnr)
  local ft = vim.bo[bufnr].filetype
  if biome_fts[ft] and uses_biome(dir) then
    return { "biome" }
  end
  if uses_prettier(dir) then
    return { "prettierd" }
  end
  return {} -- nothing configured -> lsp_format fallback (ts_ls)
end

M.formatters_by_ft = {
  lua = { "stylua" },
  javascript = pick,
  javascriptreact = pick,
  typescript = pick,
  typescriptreact = pick,
  json = pick,
  jsonc = pick,
  css = pick,
  scss = pick,
  less = pick,
  graphql = pick,
  markdown = pick,
  yaml = pick,
  html = pick,
  vue = pick,
}

M.default_format_opts = { lsp_format = "fallback" }

return M
