import os
import subprocess

from libqtile import bar, hook, layout, qtile
from libqtile.backend import base
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration

font = "SauceCodePro Nerd Font"
# font = 'arial'

colors = {
    "transparent": "#00000000",
    "rosewater": "#f2d5cf",
    "flamingo": "#eebebe",
    "pink": "#feb8e4",
    "mauve": "ca9ee6",
    "red": "e78284",
    "maroon": "#ea999c",
    "peach": "#ef9f76",
    "yellow": "#e5c890",
    "green": "#a6d189",
    "teal": "#80c8be",
    "sky": "#99d1db",
    "sapphire": "#85c1dc",
    "blue": "#8caaee",
    "lavender": "#babbf1",
    "text": "#c6d0f5",
    "subtext1": "#b5bfe2",
    "subtext0": "#a5adce",
    "overlay2": "#949cbb",
    "overlay1": "#838ba7",
    "overlay0": "#737994",
    "surface2": "#626880",
    "surface1": "#51576d",
    "surface0": "#414559",
    "base": "#303446",
    "mantle": "#292c3c",
    "crust": "#232634",
}

mod = "mod4"
terminal = "kitty -e zsh"


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        lazy.layout.section_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        lazy.layout.section_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down(),
        desc="Move window down",
    ),
    Key(
        [mod, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up(),
        desc="Move window up",
    ),
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key(
        [mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"
    ),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle floating
    Key([mod], "t", lazy.window.toggle_floating()),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod, "shift"], "Return", lazy.spawn(terminal), desc="Launch terminal"
    ),
    Key(
        [mod],
        "d",
        lazy.spawn(
            os.path.expanduser("~/.config/rofi/bin/launcher"), shell=True
        ),
        desc="Launch Rofi application launcher",
    ),
    Key(
        [mod],
        "s",
        lazy.spawn(
            os.path.expanduser("~/.config/rofi/bin/screenshot"), shell=True
        ),
        desc="Screenshot",
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod, "control"],
        "q",
        lazy.spawn(
            os.path.expanduser("~/.config/rofi/bin/powermenu"), shell=True
        ),
        desc="Open power menu",
    ),
    # Toggle between monitors
    Key([mod], "apostrophe", lazy.to_screen(0), desc="Focus monitor 1"),
    Key([mod], "comma", lazy.to_screen(1), desc="Focus monitor 2"),
    Key([mod], "period", lazy.to_screen(2), desc="Focus monitor 3"),
    Key(
        [mod],
        "space",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen",
    ),
    # Volume and brightness controls
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
    ),
]


def show_keys():
    key_help = ""
    for k in keys:
        mods = ""

        for m in k.modifiers:
            if m == "mod4":
                mods += "Super + "
            else:
                mods += m.capitalize() + " + "

        if len(k.key) > 1:
            mods += k.key.capitalize()
        else:
            mods += k.key

        key_help += "{:<30} {}".format(mods, k.desc + "\n")

    return key_help


keys.extend(
    [
        Key(
            [mod],
            "a",
            lazy.spawn(
                "sh -c 'echo \""
                + show_keys()
                + '" | rofi -dmenu -theme ~/.config/rofi/config_tall.rasi'
                + ' -i -p "?"\''
            ),
            desc="Print keyboard bindings",
        ),
    ]
)

group_props = [
    ("TERMINAL1", {"label": ""}),
    ("TERMINAL2", {"label": ""}),
    ("WEB", {"label": ""}),
    (
        "MESSAGING",
        {
            "label": "",
            "matches": [
                Match(wm_class="TelegramDesktop"),
                Match(wm_class="discord"),
                Match(wm_class="slack"),
            ],
        },
    ),
    ("MUSIC", {"label": ""}),
    ("DOCKER", {"label": ""}),
    ("BITWARDEN", {"label": "", "matches": [Match(wm_class="Bitwarden")]}),
    ("ZOOM", {"label": "", "matches": [Match(wm_class="zoom")]}),
]

groups = [
    Group(name, init=True, persist=True, **kwargs)
    for name, kwargs in group_props
]
for i, (name, kwargs) in enumerate(group_props, 1):
    keys.extend(
        [
            # mod1 + letter of group
            # switch to group
            Key(
                [mod],
                str(i),
                lazy.group[name].toscreen(),
                desc="Switch to group {}".format(name),
            ),
            # mod1 + shift + letter of group
            # switch to & move focused window to group
            Key(
                [mod, "shift"],
                str(i),
                lazy.window.togroup(name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    name
                ),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layout_theme = {
    "border_width": 2,
    "margin": 16,
    "border_focus": colors["overlay1"],
    "border_normal": colors["surface0"],
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(margin=[5, 16, 5, 16]),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadWide(**layout_theme),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font=font,
    fontsize=12,
    padding=3,
    # background=colors["transparent"],
    # decorations=[
    #     BorderDecoration(
    #         colour=colors["background"], border_width=[4, 0, 4, 0]
    #     )
    # ],
)
extension_defaults = widget_defaults.copy()


groupbox_defaults = dict(
    background=colors["mantle"],
    foregroud=colors["text"],
    # #
    active=colors["text"],
    inactive=colors["overlay0"],
    highlight_method="block",
    highlight_color=colors["subtext0"],
    block_highlight_text_color=colors["blue"],
    #
    this_current_screen_border=colors["overlay0"],
    this_screen_border=colors["surface1"],
    other_current_screen_border=colors["overlay0"],
    other_screen_border=colors["surface1"],
    #
    urgent_border=colors["maroon"],
    #
    font="SauceCodePro Nerd Font Mono",
    fontsize=24,
    margin_x=10,
    padding_x=10,
    padding_y=-3,
    borderwidth=2,
    # spacing=10,
    rounded=True,
    #
    use_mouse_wheel=False,
    disable_drag=True,
    #
    decorations=[
        RectDecoration(
            colour=colors["crust"],
            filled=True,
            radius=8,
            line_width=2,
        ),
    ],
)

sep_line_defaults = dict(
    text="|",
    font="Ubuntu Mono",
    foreground=colors["surface1"],
    padding=2,
    fontsize=14,
)

icon_defaults = dict(font=font, fontsize=15)


def create_widget_list():
    widgets_list = [
        widget.Sep(
            linewidth=0,
            padding=6,
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[
                os.path.expanduser("~/.config/qtile/icons"),
            ],
            padding=-3,
            scale=0.5,
        ),
        widget.CurrentLayout(),
        widget.TextBox(**sep_line_defaults),
        widget.WindowName(),
        widget.Spacer(),
        widget.GroupBox(
            **groupbox_defaults,
        ),
        widget.Spacer(),
        widget.Systray(),
        widget.TextBox(**sep_line_defaults),
        widget.TextBox(text="ﮮ", **icon_defaults),
        widget.CheckUpdates(
            update_interval=1800,
            distro="Arch_checkupdates",
            display_format="{updates} updates",
            no_update_string="no updates",
            foreground=colors["text"],
            colour_have_updates=colors["text"],
            colour_no_updates=colors["text"],
            # mouse_callbacks={
            #     "Button1": lambda: qtile.cmd_spawn(
            #         terminal + " -e sudo pacman -Syu"
            #     )
            # },
            # padding=5,
        ),
        widget.TextBox(**sep_line_defaults),
        widget.TextBox(
            text="",
            **icon_defaults,
        ),
        widget.CPU(
            format="{load_percent}%",
        ),
        widget.TextBox(**sep_line_defaults),
        widget.TextBox(text="", **icon_defaults),
        widget.ThermalSensor(tag_sensor="Core 0"),
        widget.TextBox(**sep_line_defaults),
        widget.Battery(
            format="{char}",
            charge_char="",
            discharge_char="",
            full_char="",
            unknown_char="",
            empty_char="",
            show_short_text=False,
            fontsize=15,
        ),
        widget.Battery(
            format="{percent:2.0%} [{hour:d}:{min:02d}]",
        ),
        widget.TextBox(**sep_line_defaults),
        widget.Clock(format="%d %b %Y - %I:%M%P"),
        widget.TextBox(**sep_line_defaults),
        widget.TextBox(
            text="⏻",
            foreground=colors["sky"],
            fontsize=18,
            padding=5,
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    os.path.expanduser("~/.config/rofi/bin/powermenu")
                )
            },
        ),
        widget.Sep(
            linewidth=0,
            padding=10,
        ),
    ]
    return widgets_list


bar_defaults = dict(
    size=35,
    background=colors["mantle"],
    # border_width=2,
    # border_color=colors["surface0"],
    margin=[8, 16, 0, 16],
)


def create_main_screen():
    return Screen(
        wallpaper="~/dotfiles/wallpapers/wallpaper.png",
        wallpaper_mode="fill",
        top=bar.Bar(create_widget_list(), **bar_defaults),
    )


def create_other_screen():
    widget_list = create_widget_list()
    del widget_list[8:-1]
    return Screen(
        wallpaper="~/dotfiles/wallpapers/wallpaper.png",
        wallpaper_mode="fill",
        top=bar.Bar(widget_list, **bar_defaults),
    )


screens = [create_main_screen(), create_other_screen(), create_other_screen()]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


def float_zoom_dialogs(win: base.Window):
    if "zoom" in win.get_wm_class() and win.name not in [
        "Zoom - Free Account",
        "Zoom - Licensed Account",
        "Zoom",
        "Zoom Meeting",
        "Zoom Cloud Meetings",
    ]:
        return True

    return False


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see
        # the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="Pavucontrol"),
        Match(wm_class="Blueman-manager"),
        Match(wm_class="Arandr"),
        Match(wm_class="Galculator"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(func=float_zoom_dialogs),
    ],
    border_width=2,
    border_focus=colors["overlay1"],
    border_normal=colors["surface0"],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    if qtile.core.name == "x11":
        subprocess.call([home + "/.config/qtile/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
