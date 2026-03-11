local M = {}

-- Base role palettes (semantic, not tied to any specific app)
M.roles = {
  dark = {
    bg = "#0B0B0B",
    fg = "#DCDCDC",
    comment = "#93979F",
    primary = "#A89ED8",
    accent = "#A89ED8",
    secondary = "#6BAAD4",
    tertiary = "#4EC4CC",
    muted = "#B2B2C1",
    error = "#D45644",
    warning = "#C4A044",
    info = "#5AAAC8",
    surface = "#171717",
    visual = "#2A2A2A",
  },
  light = {
    bg = "#F5F5F3",
    fg = "#2C2C2C",
    comment = "#9A9A9A",
    primary = "#6A5FB0",
    accent = "#6A5FB0",
    secondary = "#3A72B0",
    tertiary = "#2896A0",
    muted = "#7A7896",
    error = "#B03020",
    warning = "#906010",
    info = "#2A72A0",
    surface = "#ECECEA",
    visual = "#DDDCD8",
  },
}

function M.get(mode) return M.roles[mode] or M.roles.dark end

return M
