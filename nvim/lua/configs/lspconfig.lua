-- NvChad defaults: mapowania LSP, diagnostyka, capabilities + lua_ls
require("nvchad.configs.lspconfig").defaults()

-- Serwery bez dodatkowych ustawien (lua_ls wlacza juz NvChad powyzej)
local servers = {
  "gopls",
  "basedpyright",
  "ruff",
  "terraformls",
  "yamlls",
  "jsonls",
  "dockerls",
  "docker_compose_language_service",
  "bashls",
  "marksman",
  "html",
  "cssls",
}

vim.lsp.enable(servers)

-- :h vim.lsp.config
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
        unusedwrite = true,
        nilness = true,
      },
    },
  },
})

-- basedpyright robi typy, ruff robi lint + format -- zeby sobie nie wchodzily w droge
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        typeCheckingMode = "standard",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client, _)
    -- hover zostaje po stronie basedpyright
    client.server_capabilities.hoverProvider = false
  end,
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      -- bez tego yamlls marudzi na kolejnosc kluczy w kazdym pliku
      keyOrdering = false,
      format = { enable = false },
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/github-action.json"] = "/.github/action.{yml,yaml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/{docker-,}compose*.{yml,yaml}",
      },
    },
  },
})

vim.lsp.config("jsonls", {
  settings = {
    json = { validate = { enable = true } },
  },
})
