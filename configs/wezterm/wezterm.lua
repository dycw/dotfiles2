local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- always
config.audible_bell = "Disabled"
config.font_size = 12.0
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 200
config.initial_rows = 100
config.keys = {
	{
		key = "f",
		mods = "CMD|CTRL",
		action = wezterm.action.DisableDefaultAssignment,
	},
}
config.skip_close_confirmation_for_processes_named = {
	"bash",
	"sh",
	"zsh",
	"fish",
	"tmux",
	"nu",
	"cmd.exe",
	"pwsh.exe",
	"powershell.exe",
	"proxmox",
	"wezterm",
}
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = "8",
	right = "8",
	top = "2",
	bottom = "2",
}

-- conditional
if wezterm.hostname() == "DW-Swift" then
	config.font_size = 10.5 -- smaller
end

if wezterm.hostname() == "RH-Mac" then
	config.font_size = 12.0
end

if wezterm.hostname() == "RH-MacBook" then
	config.allow_win32_input_mode = false
	config.animation_fps = 1
	config.cursor_blink_ease_in = "Constant"
	config.cursor_blink_ease_out = "Constant"
	config.enable_scroll_bar = false
	config.font_size = 11.0 -- smaller
	config.freetype_load_target = "Light"
	config.freetype_render_target = "HorizontalLcd"
	config.hide_tab_bar_if_only_one_tab = true
	config.macos_window_background_blur = 0
	config.max_fps = 30
	config.window_background_opacity = 1.0
end
return config
