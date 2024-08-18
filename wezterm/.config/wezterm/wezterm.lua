-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "tokyonight"
config.font = wezterm.font_with_fallback({ "GeistMono", "JetBrainsMono" })
config.font_size = 12.0

-- Set background to same color as neovim
config.colors = {
  tab_bar = {
    background = "#000000",
    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = "#000000",
      fg_color = "#eb6f92",
      intensity = "Bold",
      italic = true,
    },
    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = "#000000",
      fg_color = "#e0def4",
      italic = true,
    },

    inactive_tab_hover = {
      bg_color = "#21202e",
      fg_color = "#e0def4",
      italic = true,
    },

    new_tab = {
      bg_color = "#000000",
      fg_color = "#ebbcba",
    },

    new_tab_hover = {
      bg_color = "#21202e",
      fg_color = "#e0def4",
    },
  },
}

config.colors.background = "#000000"

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the edge if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.keys = {
  { key = "1", mods = "CTRL",           action = act.ActivateTab(0) },
  { key = "2", mods = "CTRL",           action = act.ActivateTab(1) },
  { key = "3", mods = "CTRL",           action = act.ActivateTab(2) },
  { key = "4", mods = "CTRL",           action = act.ActivateTab(3) },
  { key = "5", mods = "CTRL",           action = act.ActivateTab(4) },
  { key = "6", mods = "CTRL",           action = act.ActivateTab(5) },
  { key = "7", mods = "CTRL",           action = act.ActivateTab(6) },
  { key = "8", mods = "CTRL",           action = act.ActivateTab(7) },
  { key = "9", mods = "CTRL",           action = act.ActivateTab(-1) },
  { key = "H", mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Left") },
  { key = "J", mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Down") },
  { key = "K", mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Up") },
  { key = "L", mods = "SHIFT|CTRL",     action = act.ActivatePaneDirection("Right") },
  { key = "H", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Left", 2 }) },
  { key = "J", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Down", 2 }) },
  { key = "K", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Up", 2 }) },
  { key = "L", mods = "SHIFT|ALT|CTRL", action = act.AdjustPaneSize({ "Right", 2 }) },
}

config.default_prog = { "/usr/bin/fish" }

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- and finally, return the configuration to wezterm
return config
