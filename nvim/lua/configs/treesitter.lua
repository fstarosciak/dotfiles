return {
  ensure_installed = {
    -- baza + sam config
    "lua", "luadoc", "vim", "vimdoc", "query", "printf",

    -- go
    "go", "gomod", "gosum", "gowork",

    -- python
    "python",

    -- terraform / devops
    "terraform", "hcl", "bash", "dockerfile", "toml",

    -- dane
    "json", "jsonc", "yaml",

    -- markdown / web
    "markdown", "markdown_inline", "html", "css",

    -- git
    "gitcommit", "gitignore", "diff", "regex",
  },

  highlight = { enable = true, use_languagetree = true },
  indent = { enable = true },
}
