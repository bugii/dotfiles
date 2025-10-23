local M = {}

-- Base role palettes (semantic, not tied to any specific app)
M.roles = {
  dark = {
    bg = "#0B0B0B",
    fg = "#DCDCDC",
    comment = "#93979F",
    primary = "#D9A84D",
    secondary = "#E07A2D",
    muted = "#B2B2C1",
    error = "#8B2C2C",
    warning = "#B96C2E",
    info = "#3E8CAB",
    surface = "#171717",
    visual = "#2A2A2A",
  },
  light = {
    bg = "#F5F5F3",
    fg = "#2C2C2C",
    comment = "#9A9A9A",
    primary = "#E07A2D",
    secondary = "#A88438",
    muted = "#595959",
    error = "#8B2C2C",
    warning = "#D88A45",
    info = "#3E8CAB",
    surface = "#ECECEA",
    visual = "#DDDCD8",
  },
}

function M.get(mode) return M.roles[mode] or M.roles.dark end

return M
