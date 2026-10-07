-- Jedna lista narzedzi -- mason-tool-installer doinstaluje brakujace przy starcie.
-- Nazwy sa mason-owe (nie lspconfig-owe), sprawdzalne przez :Mason.
return {
  ensure_installed = {
    -- lua
    "lua-language-server",
    "stylua",

    -- go
    "gopls",
    "gofumpt",
    "goimports",

    -- python
    "basedpyright",
    "ruff",

    -- terraform / devops
    "terraform-ls",
    "tflint",
    "yaml-language-server",
    "json-lsp",
    "dockerfile-language-server",
    "docker-compose-language-service",
    "bash-language-server",
    "shfmt",
    "shellcheck",

    -- markdown / web
    "marksman",
    "html-lsp",
    "css-lsp",
    "prettier",
  },

  run_on_start = true,
  start_delay = 2000,
  debounce_hours = 24,
}
