{
  pkgs,
  cfg,
  ...
}: let
  init-binds = import ./binds.nix {inherit pkgs;};

  c = cfg.theme.colors;
in
  pkgs.writeShellScript "river-init" ''
    #!/bin/sh

    dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

    ${init-binds}

    TOUCHPAD=$(riverctl list-inputs | rg Touchpad)
    riverctl input $TOUCHPAD accel-profile flat
    riverctl input $TOUCHPAD natural-scroll enabled
    riverctl input $TOUCHPAD click-method clickfinger
    riverctl input $TOUCHPAD tap enabled
    riverctl input $TOUCHPAD disable-when-typing enabled

    riverctl keyboard-layout -options "caps:escape" pl
    riverctl set-repeat 80 500

    riverctl background-color "0x${c.base01}"
    riverctl border-color-focused "0x${c.base04}"
    riverctl border-color-unfocused "0x${c.base02}"

    riverctl default-layout rivertile
    rivertile -view-padding 3 -outer-padding 3 &

    mako-wrapped &
    signal-desktop &
    kanshi &


  ''
