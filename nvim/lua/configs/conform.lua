local options = {
  formatters_by_ft = {
    lua = { "stylua" },

    go = { "goimports", "gofumpt" },

    python = { "ruff_organize_imports", "ruff_format" },

    terraform = { "terraform_fmt" },
    tf = { "terraform_fmt" },
    hcl = { "terraform_fmt" },

    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },

    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
  },

  formatters = {
    shfmt = { prepend_args = { "-i", "2", "-ci" } },
  },

  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
}

return options
