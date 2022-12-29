

--floart term 
-- vim.cmd[[
--     " Open a new terminal 
--     nnoremap <silent> <F1>    :FloatermNew<CR>
--     tnoremap <silent> <F1>   <C-\><C-n>:FloatermNew<CR>

--     " Kill current terminal 
--     nnoremap <silent> <S-F1> :FloatermKill<CR>:FloatermPrev<CR>
--     tnoremap <silent> <S-F1> <C-\><C-n>:FloatermKill<CR>:FloatermPrev<CR>
    
--     " Navigation next and previous terminal 
--     nnoremap <silent> <F2> :FloatermNext<CR>
--     tnoremap <silent> <F2> <C-\><C-n>:FloatermNext<CR>
--     nnoremap <silent> <C-F2> :FloatermPrev<CR>
--     tnoremap <silent> <C-F2>  <C-\><C-n>:FloatermPrev<CR>
    
--     nnoremap <silent> <F3> :FloatermHide<CR>
--     tnoremap <silent> <F3>  <C-\><C-n>:FloatermHide<CR>
    
--     nnoremap <silent> <F4> :FloatermShow<CR>
--     tnoremap <silent> <F4>  <C-\><C-n>:FloatermShow<CR>
--     nnoremap <silent> <S-F2>  :FloatermNew! --position=right --heigh
--     ]]



local fterm = require("FTerm")
fterm.setup({
  border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
})
local lazydocker = fterm:new({
  ft = 'fterm_lazydocker',
  cmd = 'lazydocker',
  dimensions = {
    height = 0.9,
    width = 0.9,
    x = 0.5,
    y = 0.5,
  },
})
local lazygit = fterm:new({
  ft = 'fterm_lazygit',
  cmd = 'lazygit',
  border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
  dimensions = {
    height = 1,
    width = 1,
    x = 0.5,
    y = 0.5,
  },
})
local ranger = fterm:new({
  ft = 'fterm_ranger',
  cmd = 'ranger',
  border = { "┏", "━", "┓", "┃", "┛","━", "┗", "┃" },
  dimensions = {
    height = 0.9,
    width = 0.9,
    x = 0.5,
    y = 0.5,
  },
})
vim.api.nvim_create_user_command('LD', function()
  lazydocker:toggle()
end, { bang = true })
vim.api.nvim_create_user_command('LG', function()
  lazygit:toggle()
end, { bang = true })
vim.api.nvim_create_user_command('Ranger', function()
  ranger:toggle()
end, { bang = true })
