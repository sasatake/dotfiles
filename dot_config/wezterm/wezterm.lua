local wezterm = require 'wezterm'
local config = {}

config.default_prog = { '/bin/zsh', '--login' }
config.automatically_reload_config = true

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0

return config