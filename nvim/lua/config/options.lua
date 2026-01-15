-- Setting
vim.opt.number = true

vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.mousemoveevent = true  -- Enable mouse events for clickable components
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.clipboard = ""
vim.opt.termguicolors = true
vim.opt.updatetime = 100

vim.opt.foldmethod = "marker"
vim.opt.cursorlineopt = "number"
-- Search
vim.opt.hlsearch = true
vim.opt.ignorecase = true

-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indent
vim.opt.autoindent = false
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4


-- Statusline
vim.opt.laststatus = 3
vim.opt.backup = false
vim.opt.fileencoding = "utf-8"
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 300
vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Undo
vim.opt.undofile = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.scrolloff = 8
vim.opt.fillchars = {
    eob = " ",
    vert = " ",      -- Ẩn đường kẻ dọc giữa các window
    horiz = " ",     -- Ẩn đường kẻ ngang
    vertleft = " ",
    vertright = " ",
    verthoriz = " ",
}

-- ============================================================================
-- Theme Cache System
-- ============================================================================
local theme_cache_path = vim.fn.stdpath("config") .. "/.theme_cache"
local default_theme = "catppuccin" -- Theme mặc định nếu không có cache

-- Hàm đọc theme từ cache
local function get_cached_theme()
    local file = io.open(theme_cache_path, "r")
    if file then
        local theme = file:read("*l")
        file:close()
        if theme and theme ~= "" then
            return theme
        end
    end
    return default_theme
end

-- Hàm lưu theme vào cache (export global để telescope dùng)
function _G.save_theme_to_cache(theme_name)
    local file = io.open(theme_cache_path, "w")
    if file then
        file:write(theme_name)
        file:close()
    end
end

-- Hàm load theme
local function load_theme(theme_name)
    local ok, _ = pcall(vim.cmd.colorscheme, theme_name)
    if not ok then
        -- Nếu theme không tồn tại, thử load default
        pcall(vim.cmd.colorscheme, default_theme)
    end
end

-- Load theme từ cache khi khởi động
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        local cached_theme = get_cached_theme()
        vim.defer_fn(function()
            load_theme(cached_theme)
        end, 1)
    end,
})

-- ============================================================================
-- Custom Highlights (áp dụng cho mọi theme)
-- ============================================================================

-- Hàm để lấy màu background tối hơn từ theme hiện tại
local function get_darker_bg()
    local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    if normal_bg then
        -- Giảm độ sáng của màu background xuống ~15%
        local r = math.floor(normal_bg / 65536)
        local g = math.floor((normal_bg % 65536) / 256)
        local b = normal_bg % 256
        r = math.max(0, math.floor(r * 0.85))
        g = math.max(0, math.floor(g * 0.85))
        b = math.max(0, math.floor(b * 0.85))
        return string.format("#%02x%02x%02x", r, g, b)
    end
    return "#1a1b26" -- Fallback color
end

-- Hàm áp dụng custom highlights cho mọi theme
local function apply_custom_highlights()
    local darker_bg = get_darker_bg()
    
    -- Ẩn WinSeparator
    vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = darker_bg })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "none", fg = darker_bg })
    
    -- Neo-tree background tối hơn
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = darker_bg })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = darker_bg })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = darker_bg, fg = darker_bg })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { bg = darker_bg, fg = darker_bg })
    vim.api.nvim_set_hl(0, "NeoTreeStatusLine", { bg = darker_bg })
    vim.api.nvim_set_hl(0, "NeoTreeStatusLineNC", { bg = darker_bg })
end

-- Áp dụng khi đổi colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        -- Delay một chút để theme load xong
        vim.defer_fn(apply_custom_highlights, 10)
    end,
})

-- -- neovide
-- if vim.g.neovide then
--   -- vim.g.neovide_cursor_animation_length = 0.085
--   -- vim.g.neovide_cursor_trail_length = 0.75
--   vim.g.neovide_cursor_vfx_mode = "torpedo" -- các chế độ khác: "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe" "railgun"

--   vim.g.neovide_transparency = 1.0
-- end

-- Biến toàn cục để theo dõi trạng thái auto-save


vim.opt.swapfile = false

-- Di chuyển xuống 10 dòng
vim.api.nvim_set_keymap("n", "<C-j>", "10j", { noremap = true, silent = true })

-- Di chuyển lên 10 dòng
vim.api.nvim_set_keymap("n", "<C-k>", "10k", { noremap = true, silent = true })


