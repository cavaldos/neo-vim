return {
  "nvzone/showkeys",
  cmd = "ShowkeysToggle",
  opts = {
    timeout = 1,
    maxkeys = 5,
    -- disable always-on to avoid stale float callbacks
    always_on = false,
  }
}
