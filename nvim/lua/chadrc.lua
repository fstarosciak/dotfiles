-- Struktura jak w https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "github_dark",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  tabufline = { lazyload = false },
}

-- nadpisania per-maszyna: lua/local.lua (w .gitignore)
pcall(function()
  local ok, localcfg = pcall(require, "local")
  if ok and type(localcfg) == "table" then
    M = vim.tbl_deep_extend("force", M, localcfg)
  end
end)

return M
