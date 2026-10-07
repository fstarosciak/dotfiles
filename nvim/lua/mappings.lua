require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "Zapisz plik" })

-- diagnostyka
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostyka w oknie plywajacym" })
map("n", "[d", function()
  vim.diagnostic.jump { count = -1 }
end, { desc = "Poprzednia diagnostyka" })
map("n", "]d", function()
  vim.diagnostic.jump { count = 1 }
end, { desc = "Nastepna diagnostyka" })

-- bufory
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Zamknij bufor" })

-- wyczysc podswietlenie wyszukiwania
map("n", "<Esc>", "<cmd>noh<cr>", { desc = "Zdejmij podswietlenie" })
