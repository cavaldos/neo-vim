require("bufferline").setup({
  options = {
    -- mode = "numbers",
    separator_style = "slant",
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    color_icons = true,
  },
})
--HACK  : Add a function to toggle the BufferLinePic


vim.cmd [[
  nnoremap <TAB> :BufferLineCycleNext<CR>
  nnoremap <S-TAB> :BufferLineCyclePrev<CR>
]]
