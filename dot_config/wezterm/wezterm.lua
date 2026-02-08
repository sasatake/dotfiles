local wezterm = require 'wezterm'
local config = {}

config.default_prog = { '/bin/zsh', '--login' }
config.automatically_reload_config = true

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0
config.use_ime = true

config.window_background_opacity = 0.75
config.macos_window_background_blur = 20

config.initial_cols = 200
config.initial_rows = 50
config.window_close_confirmation = 'NeverPrompt'

config.keys = {
  {
    key = 'RightArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'DownArrow',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'LeftArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CMD|ALT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'w',
    mods = 'CMD|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

return config