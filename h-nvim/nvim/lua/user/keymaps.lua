-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }
-- Which key
local wk = require("which-key")

--Remap space as leader key
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-.>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<A-,>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<A->>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<A-<>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<A-c>", ":bdelete<CR>", opts)

-- Save
keymap("n", "<C-s>", ":update<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move current line / block with Alt-j/k a la vscode.
keymap("v", "<A-j>", ":m '>+1<CR>gv-gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv-gv", opts)

-- Plugins --
-- Hop
keymap("n", "s", "<cmd>HopWord<CR>", opts)

-- Terminal
keymap("n", "<C-\\>", "<cmd>ToggleTerm direction=float<CR><cmd>startinsert<CR>", opts)
keymap("t", "<C-\\>", "<C-\\><C-n><cmd>ToggleTerm<CR>", opts)

-- Lsp
keymap("n", "]d", vim.diagnostic.goto_next, opts)
keymap("n", "[d", vim.diagnostic.goto_prev, opts)

-- Which-key
wk.register({
    -- NvimTree
    e = { "<cmd>NvimTreeToggle<CR>", "Explorer" },

    -- Buffer
    b = {
        name = "Buffers",
        j = {
            "<cmd>BufferLinePick<cr>",
            "Jump"
        },
        c = {
            "<cmd>BufferLinePickClose<cr>",
            "Pick which buffer to close"
        },
        h = {
            "<cmd>BufferLineCloseLeft<cr>",
            "Close all to the left"
        },
        l = {
            "<cmd>BufferLineCloseRight<cr>",
            "Close all to the right"
        }
    },

    -- Telescope
    f = {
        name = "Telescope",
        f = { "<cmd>Telescope find_files<CR>", "Find files" },
        t = { "<cmd>Telescope live_grep<CR>", "Live grep" },
        b = { "<cmd>Telescope buffers<CR>", "Buffer" },
    },

    -- Gitsigns
    g = {
        name = "Gitsigns",
        r = { "<cmd>Gitsigns reset_hunk<CR>", "Reset hunk" },
        R = { "<cmd>Gitsigns reset_buffer<CR>", "Reset Buffer" },
        u = { "<cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage hunk" },
        p = { "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk" },
        d = { "<cmd>Gitsigns diffthis<CR>", "Git diff" },
        j = { "<cmd>Gitsigns next_hunk<CR>", "Next hunk" },
        k = { "<cmd>Gitsigns prev_hunk<CR>", "Prev hunk" },
        l = { "<cmd>Gitsigns blame_line<CR>", "Blame" },
    },

    -- Lsp
    l = {
        name = "Lsp",
        g = {
            name = "Go to",
            d = { "<cmd>Telescope lsp_definitions theme=get_ivy<CR>", "Definition" },
            D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
            r = { "<cmd>Telescope lsp_references theme=get_ivy<CR>", "References" },
            i = { "<cmd>Telescope lsp_implementations theme=get_ivy<CR>", "Implementation" },
            t = { "<cmd>Telescope lsp_type_definitions theme=get_ivy<CR>", "Type definition" }
        },
        h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
        k = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
        d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Diagnostic list" },
        e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic float" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
        s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
        f = { function()
            vim.lsp.buf.format { async = true }
        end, "Format" }
    },
    -- Split Screen
    ["_"] = { "<cmd>split<CR>", "Split horizontal" },
    ["|"] = { "<cmd>vsplit<CR>", "Split vertical" },

    -- No highlight
    h = { "<cmd>noh<CR>", "Disable highlight" },

    -- Copy & Paste
    p = { "\"+p", "Paste" }
}, { mode = "n", prefix = "<leader>", silent = true })


wk.register({
    -- Copy & Paste
    y = { "\"+y", "Copy" },
    p = { "\"+p", "Paste" },

    -- Lsp
    l = {
        name = "Lsp",
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" }
    }
}, { mode = "v", prefix = "<leader>", silent = true })
