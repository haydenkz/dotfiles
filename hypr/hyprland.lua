-- Display
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.2,
})

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
end)

-- Applications
local terminal    = "ghostty"
local fileManager = "nautilus"
local menu        = "hyprlauncher"
local mainMod     = "SUPER"

-- Basic configuration
hl.config({
    general = {
        layout      = "dwindle",
        border_size = 1,
        gaps_in     = 4,
        gaps_out    = 8,
    },

    input = {
        kb_layout    = "us",
        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
            clickfinger_behavior = true, -- Two-finger press = right-click

        },
    },
})

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)

-- Applications and session
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.layout("preselect d"))
hl.bind(mainMod .. " + H", hl.dsp.layout("preselect r"))
hl.bind(
    mainMod .. " + SHIFT + SPACE",
    hl.dsp.window.float({ action = "toggle" })
)

-- Correct logout method when using UWSM
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm stop"))

-- Focus windows
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 1.5,
    bezier = "default",
})

-- Workspaces 1–10
for i = 1, 10 do
    local key = i % 10

    hl.bind(
        mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i })
    )
end

-- Volume controls
hl.bind(
    "XF86AudioRaiseVolume",
    hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86AudioLowerVolume",
    hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86AudioMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true }
)

hl.bind(
    "XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true }
)

-- Brightness controls
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("brightnessctl set 5%+"),
    { repeating = true, locked = true }
)

hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("brightnessctl set 5%-"),
    { repeating = true, locked = true }
)

-- Print: full screen, saved to Pictures and copied
hl.bind(
    "Print",
    hl.dsp.exec_cmd(
        [[sh -c 'file="$HOME/Pictures/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"; grim "$file" && wl-copy --type image/png < "$file"']]
    )
)

-- Shift + Print: selected area, saved to Pictures and copied
hl.bind(
    "SHIFT + Print",
    hl.dsp.exec_cmd(
        [[sh -c 'area="$(slurp)" || exit; file="$HOME/Pictures/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"; grim -g "$area" "$file" && wl-copy --type image/png < "$file"']]
    )
)
