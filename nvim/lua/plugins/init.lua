return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- doinstalowuje LSP-y i formattery na swiezej maszynie bez klikania w :Mason
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    opts = require "configs.mason-tools",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "configs.treesitter",
  },

  -- druga polowa nawigacji tmux <-> nvim (pierwsza jest w ~/.tmux.conf)
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Panel w lewo" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Panel w dol" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Panel w gore" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Panel w prawo" },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
      },
    },
  },
}
