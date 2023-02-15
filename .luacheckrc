---@diagnostic disable
-- vim: ft=lua tw=80

stds.nvim = {
  globals = {
    vim = { fields = { "g" } },
    os = { fields = { "capture" } }
  },
  read_globals = {
    "os",
    "vim",
    "join_paths"
  },
}
std = "lua51+nvim"
