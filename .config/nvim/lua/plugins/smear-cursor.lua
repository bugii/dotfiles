return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- some faster defaults
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    -- in case I do not want smear
    -- stiffness = 0.5,
    -- trailing_stiffness = 0.49,
    stiffness_insert_mode = 0.6,
    trailing_stiffness_insert_mode = 0.6,
    distance_stop_animating = 0.5,
  },
}
