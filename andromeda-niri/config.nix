{
  inputs,
  pkgs,
  cfg,
  ...
}: let
  inherit (inputs.niri.lib.kdl) serialize plain leaf flag node;
  inherit (cfg.theme.colors) accent;
  e = pkgs.lib.getExe;
  r = 8.0;
in
  pkgs.writeText "config.kdl"
  (serialize.nodes
    [
      (plain "input" [
        (plain "keyboard" [
          (plain "xkb" [
            (leaf "layout" "pl")
            (leaf "options" "caps:escape")
          ])
          (leaf "repeat-delay" 600)
          (leaf "repeat-rate" 25)
          (leaf "track-layout" "global")
        ])
        (plain "touchpad" [
          (flag "tap")
          (flag "dwt")
          (flag "dwtp")
          (flag "natural-scroll")
          (leaf "accel-speed" 0.00)
          (leaf "click-method" "clickfinger")
        ])
        (plain "mouse" [
          (leaf "accel-speed" 0.0)
        ])
        (plain "trackpoint" [
          (leaf "accel-speed" 0.001)
        ])
        (flag "warp-mouse-to-focus")
      ])

      (node "output" "DP-2" [
        (leaf "transform" "normal")
        (leaf "position" {
          x = 0;
          y = -1080;
        })
        (leaf "mode" "1920x1080@144.00100")
      ])
      (node "output" "eDP-1" [
        (leaf "transform" "normal")
        (leaf "position" {
          x = 0;
          y = 0;
        })
      ])

      (plain "layout" [
        (leaf "gaps" 16)
        (plain "focus-ring" [
          (leaf "width" 2)
          (leaf "active-color" "#${accent}")
        ])
        (plain "border" [(flag "off")])
        (plain "preset-column-widths" [
          (leaf "proportion" 0.333)
          (leaf "proportion" 0.5)
          (leaf "proportion" 0.333)
        ])
        (plain "default-column-width" [
          (leaf "proportion" 0.5)
        ])
        (plain "struts" [
          (leaf "left" 0)
          (leaf "right" 0)
          (leaf "bottom" 0)
          (leaf "top" 0)
        ])
        (leaf "center-focused-column" "never")
      ])

      (plain "cursor" [
        (leaf "xcursor-theme" "default")
        (leaf "xcursor-size" 24)
      ])
      (plain "animations" [
        (leaf "slowdown" 1.3)
        (plain "workspace-switch" [
          (leaf "spring" {
            damping-ratio = 0.75;
            stiffness = 400;
            epsilon = 0.0001;
          })
        ])
        (plain "horizontal-view-movement" [
          (leaf "spring" {
            damping-ratio = 0.75;
            stiffness = 400;
            epsilon = 0.0001;
          })
        ])
        (plain "window-movement" [
          (leaf "spring" {
            damping-ratio = 0.75;
            stiffness = 400;
            epsilon = 0.0001;
          })
        ])

        (plain "window-open" [
          (leaf "spring" {
            damping-ratio = 0.58;
            stiffness = 735;
            epsilon = 0.0001;
          })
        ])
        (plain "window-close" [
          (leaf "spring" {
            damping-ratio = 0.58;
            stiffness = 735;
            epsilon = 0.0001;
          })
        ])
      ])
      (plain "window-rule" [
        (leaf "clip-to-geometry" true)
        (leaf "geometry-corner-radius" [r r r r])
      ])
      (plain "hotkey-overlay" [
        (flag "skip-at-startup")
      ])
      (plain "binds" [
        (plain "Mod+Return" [(leaf "spawn" ["foot"])])
        (plain "Mod+Shift+L" [(leaf "spawn" ["gtklock"])])
        (plain "Mod+Space" [(leaf "spawn" ["launcher" "-show" "drun"])])
        (plain "XF86Keyboard" [(leaf "spawn" ["launcher" "-show" "calc"])])
        (plain "XF86Favorites" [(leaf "spawn" ["launcher" "-show" "emoji"])])
        (plain "XF86Tools" [(leaf "spawn" ["infoscript"])])

        (plain "XF86AudioRaiseVolume" [(leaf "spawn" ["pamixer" "-i" "5"])])
        (plain "XF86AudioLowerVolume" [(leaf "spawn" ["pamixer" "-d" "5"])])
        (plain "XF86AudioMute" [(leaf "spawn" ["pamixer" "-t"])])

        (plain "XF86MonBrightnessUp" [(leaf "spawn" ["brightnessctl" "set" "+5%"])])
        (plain "XF86MonBrightnessDown" [(leaf "spawn" ["brightnessctl" "set" "5%-"])])

        (plain "Mod+Q" [(flag "close-window")])

        (plain "Mod+H" [(flag "focus-column-left")])
        (plain "Mod+J" [(flag "focus-window-or-workspace-down")])
        (plain "Mod+K" [(flag "focus-window-or-workspace-up")])
        (plain "Mod+L" [(flag "focus-column-right")])

        (plain "Mod+Ctrl+H" [(flag "move-column-left")])
        (plain "Mod+Ctrl+J" [(flag "move-window-down-or-to-workspace-down")])
        (plain "Mod+Ctrl+K" [(flag "move-window-up-or-to-workspace-up")])
        (plain "Mod+Ctrl+L" [(flag "move-column-right")])

        (plain "Mod+Home" [(flag "focus-column-first")])
        (plain "Mod+End" [(flag "focus-column-last")])
        (plain "Mod+Ctrl+Home" [(flag "move-column-to-first")])
        (plain "Mod+Ctrl+End" [(flag "move-column-to-last")])

        (plain "Mod+Shift+H" [(flag "focus-monitor-left")])
        (plain "Mod+Shift+J" [(flag "focus-monitor-down")])

        (plain "Mod+Shift+Ctrl+Left" [(flag "move-column-to-monitor-left")])
        (plain "Mod+Shift+Ctrl+Down" [(flag "move-column-to-monitor-down")])
        (plain "Mod+Shift+Ctrl+Up" [(flag "move-column-to-monitor-up")])
        (plain "Mod+Shift+Ctrl+Right" [(flag "move-column-to-monitor-right")])
        (plain "Mod+Shift+Ctrl+H" [(flag "move-column-to-monitor-left")])
        (plain "Mod+Shift+Ctrl+J" [(flag "move-column-to-monitor-down")])
        (plain "Mod+Shift+Ctrl+K" [(flag "move-column-to-monitor-up")])
        (plain "Mod+Shift+Ctrl+L" [(flag "move-column-to-monitor-right")])

        (plain "Mod+Page_Down" [(flag "focus-workspace-down")])
        (plain "Mod+Page_Up" [(flag "focus-workspace-up")])
        (plain "Mod+U" [(flag "focus-workspace-down")])
        (plain "Mod+I" [(flag "focus-workspace-up")])
        (plain "Mod+Ctrl+Page_Down" [(flag "move-column-to-workspace-down")])
        (plain "Mod+Ctrl+Page_Up" [(flag "move-column-to-workspace-up")])
        (plain "Mod+Ctrl+U" [(flag "move-column-to-workspace-down")])
        (plain "Mod+Ctrl+I" [(flag "move-column-to-workspace-up")])

        (plain "Mod+Shift+Page_Down" [(flag "move-workspace-down")])
        (plain "Mod+Shift+Page_Up" [(flag "move-workspace-up")])
        (plain "Mod+Shift+U" [(flag "move-workspace-down")])
        (plain "Mod+Shift+I" [(flag "move-workspace-up")])

        # TODO: loop
        (plain "Mod+1" [(leaf "focus-workspace" 1)])
        (plain "Mod+2" [(leaf "focus-workspace" 2)])
        (plain "Mod+3" [(leaf "focus-workspace" 3)])
        (plain "Mod+4" [(leaf "focus-workspace" 4)])
        (plain "Mod+5" [(leaf "focus-workspace" 5)])
        (plain "Mod+6" [(leaf "focus-workspace" 6)])
        (plain "Mod+7" [(leaf "focus-workspace" 7)])
        (plain "Mod+8" [(leaf "focus-workspace" 8)])
        (plain "Mod+9" [(leaf "focus-workspace" 9)])
        (plain "Mod+Ctrl+1" [(leaf "move-column-to-workspace" 1)])
        (plain "Mod+Ctrl+2" [(leaf "move-column-to-workspace" 2)])
        (plain "Mod+Ctrl+3" [(leaf "move-column-to-workspace" 3)])
        (plain "Mod+Ctrl+4" [(leaf "move-column-to-workspace" 4)])
        (plain "Mod+Ctrl+5" [(leaf "move-column-to-workspace" 5)])
        (plain "Mod+Ctrl+6" [(leaf "move-column-to-workspace" 6)])
        (plain "Mod+Ctrl+7" [(leaf "move-column-to-workspace" 7)])
        (plain "Mod+Ctrl+8" [(leaf "move-column-to-workspace" 8)])
        (plain "Mod+Ctrl+9" [(leaf "move-column-to-workspace" 9)])

        (plain "Mod+Comma" [(flag "consume-window-into-column")])
        (plain "Mod+Period" [(flag "expel-window-from-column")])

        (plain "Mod+R" [(flag "switch-preset-column-width")])
        (plain "Mod+F" [(flag "maximize-column")])
        (plain "Mod+Shift+F" [(flag "fullscreen-window")])
        (plain "Mod+C" [(flag "center-column")])

        (plain "Mod+Minus" [(leaf "set-column-width" "-10%")])
        (plain "Mod+Equal" [(leaf "set-column-width" "+10%")])

        (plain "Mod+Shift+Minus" [(leaf "set-window-height" "-10%")])
        (plain "Mod+Shift+Equal" [(leaf "set-window-height" "+10%")])

        (plain "Mod+Shift+S" [(flag "screenshot")])
        (plain "Mod+Shift+Print" [(flag "screenshot-window")])
        (plain "Mod+Print" [(flag "screenshot-screen")])

        (plain "Mod+Shift+P" [(flag "power-off-monitors")])
      ])
      (leaf "spawn-at-startup" [
        "${pkgs.dbus}/bin/dbus-update-activation-environment"
        "--systemd"
        "DISPLAY"
        "WAYLAND_DISPLAY"
        "SWAYSOCK"
        "XDG_CURRENT_DESKTOP"
        "XDG_SESSION_TYPE"
        "NIXOS_OZONE_WL"
        "XCURSOR_THEME"
        "XCURSOR_SIZE"
        "XDG_DATA_DIRS"
      ])
      (leaf "spawn-at-startup" ["mako-wrapped"])
      (leaf "spawn-at-startup" ["${e pkgs.swaybg}" "-i" "${./wall.jpg}"])
      (leaf "spawn-at-startup" ["${e pkgs.wlsunset}" "-l" "50.0" "-L" "19.94"])
      (leaf "spawn-at-startup" ["${e pkgs.sway-audio-idle-inhibit}"])

      (leaf "spawn-at-startup" ["swayidle"])
      (leaf "screenshot-path" "~/pics/ss/ss%Y-%m-%d %H-%M-%S.png")
      (flag "environment")
      (flag "prefer-no-csd")
    ])
