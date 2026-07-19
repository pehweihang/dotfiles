local colors = require("current-theme")
hl.monitor({ output = "eDP-1", mode = "2256x1504@60.00", position = "0x0", scale = 1 })
hl.monitor({
	output = "desc:LG Electronics LG HDR WQHD 107NTAB4N912",
	mode = "3440x1440@99.98Hz",
	position = "auto-right",
	scale = 1,
})

hl.on("hyprland.start", function()
	hl.dsp.exec_cmd("uwsm app -- ${HOME}/.config/hypr/scripts/bitwarden-resize.sh")
	hl.dsp.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist --max-items 10000 store")
	hl.dsp.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist --max-items 10000 store")
	hl.dsp.exec_cmd("uwsm app -- swayosd-server")
	hl.dsp.exec_cmd("uwsm app -- /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.dsp.exec_cmd("uwsm app -- protonmail-bridge-core --cli")

	hl.dsp.exec_cmd("hyprctl dispatch exec [workspace 1 silent] uwsm app -- kitty zsh")
	hl.dsp.exec_cmd("hyprctl dispatch exec [workspace 2 silent] uwsm app -- zen-browser")
	hl.dsp.exec_cmd("hyprctl dispatch exec [workspace 3 silent] uwsm app -- Telegram")
	hl.dsp.exec_cmd("hyprctl dispatch exec [workspace 4 silent] uwsm app -- thunderbird")
end)

hl.config({
	general = {
		border_size = 3,
		gaps_in = 10,
		gaps_out = 10,
		gaps_workspaces = 0,
		col = {
			inactive_border = colors.surface2,
			active_border = colors.rosewater,
			nogroup_border = colors.surface2,
			nogroup_border_active = colors.rosewater,
		},
		layout = "master",
		no_focus_fallback = true,
		resize_on_border = false,
		hover_icon_on_border = false,
		snap = { enabled = false },
	},
	decoration = {
		rounding = 15,
		rounding_power = 4.0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		fullscreen_opacity = 1.0,
		dim_inactive = false,
		blur = {
			enabled = false,
		},
	},
	animations = {
		enabled = true,
	},
	input = {
		kb_layout = "us",
		scroll_method = "2fg",
		natural_scroll = false,
		follow_mouse = 2,
		mouse_refocus = true,
		float_switch_override_focus = 0,
		touchpad = {
			clickfinger_behavior = true,
			natural_scroll = true,
		},
	},
	group = {
		auto_group = false,
		merge_groups_on_drag = false,
		col = {
			border_active = colors.rosewater,
			border_inactive = colors.surface2,
		},
		groupbar = {
			enabled = true,
			font_family = "Inter",
			font_size = 10,
		},
	},
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 2,
		mouse_move_enables_dpms = false,
		key_press_enables_dpms = true,
		animate_manual_resizes = true,
	},
	ecosystem = {
		no_donation_nag = true,
	},
})

local mainMod = "SUPER"
local terminal = "kitty zsh"

-- Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
hl.bind(mainMod .. " + SHIFT + return", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + CTRL + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + space", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/launcher"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
--
-- Notifications
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("uwsm app -- swaync-client -t"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("uwsm app -- swaync-client -C"))
--
-- Toggle group
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + tab", hl.dsp.group.next())
hl.bind(mainMod .. " + SHIFT + tab", hl.dsp.group.prev())
--
-- Move focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
--
-- Move window in workspace
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up", group_aware = true }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right", group_aware = true }))
--
-- Resize window
hl.bind(mainMod .. " + CONTROL + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind(mainMod .. " + CONTROL + j", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind(mainMod .. " + CONTROL + k", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))
hl.bind(mainMod .. " + CONTROL + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
--
-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
--
-- Switch and move workspaces
hl.bind(mainMod .. " + CTRL + 1", hl.dsp.focus({ workspace = 1, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 2", hl.dsp.focus({ workspace = 2, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 3", hl.dsp.focus({ workspace = 3, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 4", hl.dsp.focus({ workspace = 4, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 5", hl.dsp.focus({ workspace = 5, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 6", hl.dsp.focus({ workspace = 6, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 7", hl.dsp.focus({ workspace = 7, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 8", hl.dsp.focus({ workspace = 8, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 9", hl.dsp.focus({ workspace = 9, on_current_monitor = true }))
hl.bind(mainMod .. " + CTRL + 0", hl.dsp.focus({ workspace = 10, on_current_monitor = true }))
--
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
--
-- Focus monitors
hl.bind(mainMod .. " + comma", hl.dsp.focus({ monitor = -1 }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ monitor = 1 }))
--
-- Move monitor workspaces
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ monitor = -1 }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ monitor = 1 }))
--
-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("special"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
--
-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
--
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume mute-toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("uwsm app -- swayosd-client --input-volume mute-toggle"))
--
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume 5 --max-volume 120"))
hl.bind(
	"CONTROL + XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume 1 --max-volume 120")
)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume -5 --max-volume 120"))
hl.bind(
	"CONTROL + XF86AudioLowerVolume",
	hl.dsp.exec_cmd("uwsm app -- swayosd-client --output-volume -1 --max-volume 120")
)
--
--
-- Brightness raise
-- TODO: bug with relative amount changes
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("uwsm app -- swayosd-client --brightness raise"))
hl.bind("CONTROL + XF86MonBrightnessUp", hl.dsp.exec_cmd("uwsm app -- swayosd-client --brightness rasie"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("uwsm app -- swayosd-client --brightness lower"))
hl.bind("CONTROL + XF86MonBrightnessDown", hl.dsp.exec_cmd("uwsm app -- swayosd-client --brightness lower"))
--
-- Menus
hl.bind(mainMod .. " + M", hl.dsp.submap("menus"))
hl.define_submap("menus", function()
	hl.bind(" + F", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/xdg-open"))
	hl.bind(" + S", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/sound"))
	hl.bind(" + C", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/calculator"))
	hl.bind(" + V", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/clipboard"))
	hl.bind(" + P", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/grimblast-satty"))
	hl.bind("SHIFT + P", hl.dsp.exec_cmd("uwsm app -- $HOME/.local/bin/grimblast-satty s"))
	hl.bind("CONTROL + P", hl.dsp.exec_cmd("uwsm app -- $HOME/.local/bin/grimblast-satty m"))
	hl.bind("CONTROL + SHIFT + P", hl.dsp.exec_cmd("uwsm app -- $HOME/.local/bin/grimblast-satty sf"))
	hl.bind(" + T", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/tailscale"))
	hl.bind(" + L", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/rbw"))
	hl.bind(" + B", hl.dsp.exec_cmd("uwsm app -- $HOME/.config/rofi/bin/bluetooth"))
	hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- Pause all bindings
hl.bind(mainMod .. " + SHIFT + CONTROL + ALT + P", hl.dsp.submap("pause"))
hl.define_submap("pause", function()
	hl.bind(mainMod .. " + SHIFT + CONTROL + ALT + P", hl.dsp.submap("reset"))
end)
