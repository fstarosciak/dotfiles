-- Instalacja narzedzi mason w trybie headless.
-- :MasonToolsInstall nie nadaje sie do bootstrapu -- mason-tool-installer siedzi
-- na VeryLazy, wiec w headless komenda nie istnieje jeszcze w chwili wywolania.
-- Tutaj ladujemy rejestr wprost i czekamy na zakonczenie instalacji.

local tools = require("configs.mason-tools").ensure_installed

require("lazy").load { plugins = { "mason.nvim" } }
local registry = require "mason-registry"

registry.refresh()

local pending, failed = 0, {}

for _, name in ipairs(tools) do
  local ok, pkg = pcall(registry.get_package, name)
  if not ok then
    table.insert(failed, name .. " (brak w rejestrze)")
  elseif pkg:is_installed() then
    print("[ jest ] " .. name)
  else
    pending = pending + 1
    print("[ inst ] " .. name)
    pkg:once("install:success", function()
      pending = pending - 1
    end)
    pkg:once("install:failed", function()
      table.insert(failed, name)
      pending = pending - 1
    end)
    pkg:install()
  end
end

local done = vim.wait(900000, function()
  return pending == 0
end, 500)

if not done then
  print "!! timeout"
end

if #failed > 0 then
  print("!! nie udalo sie: " .. table.concat(failed, ", "))
else
  print "== wszystkie narzedzia zainstalowane =="
end

vim.cmd "qall!"
