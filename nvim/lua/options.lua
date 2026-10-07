require "nvchad.options"

local o = vim.o

o.relativenumber = true
o.cursorlineopt = "both"
o.scrolloff = 8
o.sidescrolloff = 8

-- trwale undo miedzy sesjami
o.undofile = true
o.undolevels = 10000

o.ignorecase = true
o.smartcase = true

o.splitright = true
o.splitbelow = true

-- pyta zamiast odmawiac zamkniecia niezapisanego bufora
o.confirm = true

o.updatetime = 250
o.timeoutlen = 400
