{
  pkgs,
  cfg,
  ...
}: {
  basePackage = pkgs.rofi-wayland.override {
    plugins = with pkgs; [
      (rofi-calc.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
      (rofi-emoji.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
    ];
  };
  flags = [
    "-theme"
    "${./andromeda.rasi}"
    "-combi-modi"
    "drun,emoji,calc"
  ];
  renames = {
    "rofi" = "launcher";
  };
}
