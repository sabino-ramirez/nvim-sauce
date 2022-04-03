local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.opt.termguicolors = true
vim.opt.list = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#454545 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#383838 gui=nocombine]]

--vim.opt.listchars:append("space:⋅")
--vim.opt.listchars:append("eol:↴")

indent_blankline.setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

--for line comprised of chars
--indent_blankline.setup {
--
--   require("indent_blankline").setup {
--     char = "○",
--     use_treesitter = true,
--     --char = "◦",
--     --char_list = {'○', 'i'},
--     space_char_blankline = " ",
--     show_trailing_blankline_indent = false,
--   }
-- }
