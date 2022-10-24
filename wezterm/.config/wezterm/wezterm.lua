local wezterm = require("wezterm")
return {
	-- font = wezterm.font_with_fallback({
	-- 	"Monaco",
	-- 	"Fira Code",
	-- 	"DengXian",
	-- }),
	-- font_size = 14.0,
	enable_tab_bar = false,
	enable_scrollbar = false,
	color_scheme = "Broadcast",
	-- font = wezterm.font("Monego Nerd Font Fix"),
	-- font = wezterm.font({ family = "Monego Nerd Font Fix" }),
	-- font = wezterm.font({ family = "Monaco", weight = "Bold" }),
	-- font = wezterm.font("InconsolataLGC Nerd Font Mono"),
	font = wezterm.font("Source Code Pro Semibold"),
	font_size = 14.5,
	-- freetype_load_target = "Light",
	-- freetype_render_target = "HorizontalLcd",
	-- dpi = 81.0,
	-- bold_brightens_ansi_colors = true,
	-- front_end = "OpenGL",
	-- prefer_egl = true,
	-- freetype_load_target = "HorizontalLcd",

	-- font = wezterm.font("Source Code Pro Semibold"),

	-- freetype_load_flags = "NO_HINTING|NO_AUTOHINT",

	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 1.2, -- default is 1.0
	},

	-- freetype_load_target = "HorizontalLcd",

	-- window_padding = {
	-- 	left = 0,
	-- 	right = 0,
	-- 	top = 0,
	-- 	bottom = 0,
	-- },
}
