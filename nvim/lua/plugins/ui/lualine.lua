return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    priority = 1000,
    config = function()
        -- Function to get color from highlight group
        local function get_hl_color(group, attr)
            local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
            if not ok or not hl then
                return nil
            end
            if attr == 'fg' then
                return hl.fg and string.format('#%06x', hl.fg) or nil
            elseif attr == 'bg' then
                return hl.bg and string.format('#%06x', hl.bg) or nil
            end
        end

        -- Get colors from current colorscheme
        local function get_colors()
            return {
                red = get_hl_color('DiagnosticError', 'fg') or '#ca1243',
                grey = get_hl_color('Comment', 'fg') or '#a0a1a7',
                black = get_hl_color('Normal', 'bg') or '#383a42',
                white = get_hl_color('Normal', 'fg') or '#f3f3f3',
                light_green = get_hl_color('String', 'fg') or '#83a598',
                orange = get_hl_color('DiagnosticWarn', 'fg') or '#fe8019',
                green = get_hl_color('DiagnosticOk', 'fg') or get_hl_color('String', 'fg') or '#8ec07c',
                blue = get_hl_color('Function', 'fg') or '#61afef',
                cyan = get_hl_color('DiagnosticInfo', 'fg') or '#56b6c2',
                violet = get_hl_color('Statement', 'fg') or '#c678dd',
                yellow = get_hl_color('WarningMsg', 'fg') or '#e5c07b',
            }
        end

        -- Search result function
        local function search_result()
            if vim.v.hlsearch == 0 then
                return ''
            end
            local last_search = vim.fn.getreg('/')
            if not last_search or last_search == '' then
                return ''
            end
            local searchcount = vim.fn.searchcount { maxcount = 9999 }
            return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
        end

        -- Modified indicator
        local function modified()
            if vim.bo.modified then
                return '+'
            elseif vim.bo.modifiable == false or vim.bo.readonly == true then
                return '-'
            end
            return ''
        end

        -- LSP server name
        local function lsp_server()
            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
            local clients = vim.lsp.get_clients()
            if next(clients) == nil then
                return ''
            end
            for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                    return ' ' .. client.name
                end
            end
            return ''
        end

        -- Macro recording indicator
        local function macro_recording()
            local reg = vim.fn.reg_recording()
            if reg ~= '' then
                return '󰑋 ' .. reg
            end
            return ''
        end

        -- LSP status
        local function lsp_status()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
                return ''
            end

            local status_parts = {}
            for _, client in ipairs(clients) do
                local status = ''
                if client.initialized then
                    local progress = vim.lsp.status()
                    if progress and progress ~= '' then
                        status = '󰔟 ' .. client.name .. ' ' .. progress
                    else
                        status = '󰄬 ' .. client.name
                    end
                else
                    status = '󰦗 ' .. client.name .. '...'
                end
                table.insert(status_parts, status)
            end

            return table.concat(status_parts, 'd | ')
        end

        -- LSP progress
        local function lsp_progress()
            local progress = vim.lsp.status()
            if progress and progress ~= '' then
                return '󰔟 ' .. progress
            end
            return ''
        end

        require('lualine').setup {
            options = {
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    -- Margin trái
                    {
                        function() return '  ' end,
                        padding = 0,
                        color = { bg = 'NONE', fg = 'NONE' },
                    },
                    {  
                        'mode', -- icon cho chế độ NORMAL
                        fmt = function(str)
                            if str == 'NORMAL' then
                                return ' ' .. str
                            elseif str == 'INSERT' then
                                return ' ' .. str
                            elseif str == 'VISUAL' then
                                return ' ' .. str
                            elseif str == 'COMMAND' then
                                return ' ' .. str
                            end
                            return str
                        end,
                        padding = { left = 1, right = 1 }
                    },
                },
                lualine_b = {
                    'branch',
                    {
                        'diff',
                        symbols = { added = ' ', modified = ' ', removed = ' ' },
                    },
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌵 ' },
                        colored = true,
                        update_in_insert = false,
                        always_visible = false,
                        diagnostics_color = {
                            error = function()
                                local c = get_colors()
                                return { fg = c.red, bg = c.black }
                            end,
                            warn = function()
                                local c = get_colors()
                                return { fg = c.orange, bg = c.black }
                            end,
                            info = function()
                                local c = get_colors()
                                return { fg = c.cyan, bg = c.black }
                            end,
                            hint = function()
                                local c = get_colors()
                                return { fg = c.green, bg = c.black }
                            end,
                        },
                    },
                    { 'filename', file_status = false, path = 1 },
                    {
                        modified,
                        color = function()
                            local c = get_colors()
                            return { bg = c.red, fg = c.white }
                        end,
                    },
                },
                lualine_c = {
                    {
                        lsp_server,
                        color = function()
                            local c = get_colors()
                            return { fg = c.violet, gui = 'bold' }
                        end,
                    },
                    {
                        lsp_status,
                        color = function()
                            local c = get_colors()
                            return { fg = c.cyan, gui = 'bold' }
                        end,
                    },
                    {
                        lsp_progress,
                        color = function()
                            local c = get_colors()
                            return { fg = c.yellow }
                        end,
                    },
                    {
                        macro_recording,
                        color = function()
                            local c = get_colors()
                            return { fg = c.red, gui = 'bold' }
                        end,
                    },
                },
                lualine_x = {
                    {
                        'selectioncount',
                        color = function()
                            local c = get_colors()
                            return { fg = c.green, gui = 'bold' }
                        end,
                    },
                },
                lualine_y = {
                    {
                        search_result,
                        color = function()
                            local c = get_colors()
                            return { fg = c.cyan }
                        end,
                    },
                    'encoding',
                    'fileformat',
                    'filetype',
                    
                },
                lualine_z = {
                    { '%l:%c', padding = { left = 1, right = 1 } },
                    { '%p%%/%L', padding = { left = 1, right = 1 } },
                    -- icon gear setting
                    {
                        function() return ' ' end,
                        padding = { left = 1, right = 0 },
                        color = function()
                            local c = get_colors()
                            return { fg = c.yellow, bg = c.black }
                        end,
                    },
                    -- Margin phải
                    {
                        function() return '  ' end,
                        padding = 0,
                        color = { bg = 'NONE', fg = 'NONE' },
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { '%f %y %m' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
            extensions = { 'neo-tree', 'quickfix' },
        }
    end,
}
