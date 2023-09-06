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
        noremap <silent> <C-S>  :update<CR>
        vnoremap <silent> <C-S>  <C-C>:update<CR>
        inoremap <silent> <C-S> <C-O>:update<CR>
        map <silent> <C-s> :w <CR>
        map <silent> <S-s> :w <CR>
        map <silent> <C-q> :q! <CR>
      
]]
vim.cmd('nnoremap <F1> :Neotree toggle<CR>')
vim.cmd('nnoremap <S-F1> :NvimTreeToggle<CR> ')

