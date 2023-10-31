local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local night = {
    bg = "#1a1b26",
    bg_dark = "#16161e",
    bg_highlight = "#292e42",
    fg = "#c0caf5",
    fg_dark = "#a9b1d6",
    red = "#f7768e",
    red1 = "#db4b4b",
}

local theme = {}

theme.font = "GeistMono 8"
theme.bg_normal = night.bg_dark
theme.bg_focus = night.bg_highlight
theme.bg_urgent = night.red
theme.bg_minimize = night.bg
theme.bg_systray = theme.bg_normal

theme.fg_normal = night.fg_dark
theme.fg_focus = night.fg
theme.fg_urgent = theme.fg_focus
theme.fg_minimize = theme.fg_focus

theme.useless_gap = dpi(0)
theme.border_width = dpi(1)
theme.border_normal = night.bg
theme.border_focus = night.bg_highlight
theme.border_marked = night.red1

-- Generate taglist squares:
local taglist_square_size = dpi(2)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
theme.notification_font = "GeistMono 8"
theme.notification_bg = night.bg_dark
theme.notification_fg = night.bg_highlight
theme.notification_width = 50
theme.notification_height = 35
-- theme.notification\_border\_width = nil
-- theme.notification\_border\_color = nil
-- theme.notification\_shape = nil
-- theme.notification\_opacity = nil
-- theme.notification\_margin = nil
-- theme.notification\_max\_width = nil
-- theme.notification\_max\_height = nil
-- theme.notification\_icon\_size = nil

theme.wallpaper = "/home/sushi/Downloads/wallpaps/current.png"

-- You can use your own layout icons like this:
theme.layout_tilebottom = themes_path .. "default/layouts/tilebottomw.png"
theme.layout_tileleft = themes_path .. "default/layouts/tileleftw.png"
theme.layout_tile = themes_path .. "default/layouts/tilew.png"
theme.layout_spiral = themes_path .. "default/layouts/spiralw.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
