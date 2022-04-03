return {
  cmd = { "solang", "--language-server", "--target", "ewasm" },
  filetypes = { "solidity" },
  root_dir = function()
    return vim.fn.getcwd()
  end
}
