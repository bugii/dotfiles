return {
  "tpope/vim-fugitive",
  lazy = false,
  -- Ensure that this has prio lower than mini.git (default is 50) because annoyoingly there is no way to disable creating user commands
  -- but i still need the mini.git plugin for the statusline icons to work.
  priority = 10,
}
