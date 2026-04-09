local M = {}

-- Base role palettes (semantic, not tied to any specific app)
M.roles = {
  dark = {
    bg = "#0B0B0B",
    fg = "#DCDCDC",
    comment = "#6E6A86",
    primary = "#C4A7E7",
    accent = "#C4A7E7",
    secondary = "#9CCFD8",
    tertiary = "#EBBCBA",
    muted = "#908CAA",
    error = "#EB6F92",
    warning = "#F6C177",
    info = "#9CCFD8",
    surface = "#171717",
    visual = "#2A2A2A",
  },
  light = {
    bg = "#FAF4ED",
    fg = "#575279",
    comment = "#9893A5",
    primary = "#907AA9",
    accent = "#907AA9",
    secondary = "#56949F",
    tertiary = "#D7827E",
    muted = "#797593",
    error = "#B4637A",
    warning = "#EA9D34",
    info = "#56949F",
    surface = "#F2E9E1",
    visual = "#DFDAD9",
  },
}

function M.get(mode) return M.roles[mode] or M.roles.dark end

return M
