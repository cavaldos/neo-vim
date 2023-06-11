vim.cmd [[

        imap <F1> <nop>
        imap <F3> <nop>
        imap <F6> <nop>
        nmap ew  <C-w>
        nmap  ww <C-w>w    
        imap <C-v> <ESC>p 
        imap vv <ESC>
        imap <F1><F1>  <ESC>
        imap <F3><F3>  <ESC>
        imap <F6><F6>  <ESC>
        noremap <silent> <C-S>          :update<CR>
        vnoremap <silent> <C-S>         <C-C>:update<CR>
        inoremap <silent> <C-S>         <C-O>:update<CR>
        map <silent> <C-s> :w <CR>
        map <silent> <S-s> :w <CR>
        map <silent> <C-q> :q! <CR>
      
]]

--file manager
vim.cmd('nnoremap <F1> :Neotree toggle<CR>')
vim.cmd('nnoremap <S-F1> :NvimTreeToggle<CR> ')
--buffer lua
-- vim.cmd[[
-- nnoremap <TAB> :BufferLineCycleNext<CR>
-- nnoremap <S-TAB> :BufferLineCyclePrev<CR>]]

-- --terminal
vim.cmd('nnoremap r<F3> :ToggleTerm direction=float<CR>')
vim.cmd('nnoremap <F3> :ToggleTerm direction=horizontal<CR>')
vim.cmd('nnoremap t<F3> :ToggleTerm  direction=vertical<CR>')

vim.cmd('map r<F3> :ToggleTerm direction=float<CR>')
vim.cmd('map <F3> :ToggleTerm direction=horizontal<CR>')
vim.cmd('map t<F3> :ToggleTerm  direction=vertical<CR>')

vim.cmd('tmap <F3>: exit<CR> ')


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<F6>', builtin.find_files, {})
vim.keymap.set('n', '<S-F6>', builtin.live_grep, {})
--  vim.keymap.set('n', '<F6>fb', builtin.buffers, {})
vim.keymap.set('n', '<C-F6>', builtin.help_tags, {})
vim.keymap.set('n', '<C-F6>fh', builtin.help_tags, {})


---aerial


vim.cmd('map <F2> :AerialToggle <CR>')



-- --terminal
vim.cmd('nnoremap r<F3> :ToggleTerm direction=float<CR>')
vim.cmd('nnoremap <F3> :ToggleTerm direction=horizontal<CR>')
vim.cmd('nnoremap t<F3> :ToggleTerm  direction=vertical<CR>')

vim.cmd('map r<F3> :ToggleTerm direction=float<CR>')
vim.cmd('map <F3> :ToggleTerm direction=horizontal<CR>')
vim.cmd('map t<F3> :ToggleTerm  direction=vertical<CR>')

vim.cmd('tmap <F3>: exit<CR> ')

---aerial

vim.cmd('map <F2> :AerialToggle <CR>')
vim.cmd('map <S-F2> :Lspsaga outline <CR>')
vim.cmd('map r<F2> :Lspsaga rename <CR>')
vim.cmd('map <silent> ff  :Lspsaga  show_line_diagnostics  <CR>')

---- floart term
vim.cmd [[
    " Open a new terminal 
    nnoremap <silent> <F12>    :FloatermNew<CR>
    tnoremap <silent> <F122>   <C-\><C-n>:FloatermNew<CR>

    " Kill current terminal 
    nnoremap <silent> <S-F12> :FloatermKill<CR>:FloatermPrev<CR>
    tnoremap <silent> <S-F12> <C-\><C-n>:FloatermKill<CR>:FloatermPrev<CR>
    
    " Navigation next and previous terminal 
    nnoremap <silent> <C-F12> :FloatermNext<CR>
    tnoremap <silent> <C-F12> <C-\><C-n>:FloatermNext<CR>
    nnoremap <silent> <C-F2> :FloatermPrev<CR>
    tnoremap <silent> <C-F2>  <C-\><C-n>:FloatermPrev<CR>
    
    nnoremap <silent> <F11> :FloatermHide<CR>
    tnoremap <silent> <F11>  <C-\><C-n>:FloatermHide<CR>
    
    nnoremap <silent> <F10> :FloatermShow<CR>
    tnoremap <silent> <F10>  <C-\><C-n>:FloatermShow<CR>
    "nnoremap <silent> <S-F2>  :FloatermNew! --position=right --heigh
    ]]
