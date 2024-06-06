{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.niri.lib.kdl) serialize plain leaf flag;
in
  # TODO: Write rest of the config
  pkgs.writeText "config.kdl" (
    serialize.nodes
    [
      (plain "input" [
        (plain "keyboard" [
          (plain "xkb" [
            (leaf "layout" "pl")
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
    ]
  )
