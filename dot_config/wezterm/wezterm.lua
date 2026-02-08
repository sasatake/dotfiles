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


return config