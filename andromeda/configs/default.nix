{
  inputs,
  pkgs,
  cfg,
  ...
}: {
  foot = import ./foot {inherit inputs pkgs cfg;};
  ags = import ./ags {inherit inputs pkgs cfg;};

  gtklock = import ./gtklock {inherit pkgs;};
  rofi = import ./rofi {inherit pkgs cfg;};
  swayidle = import ./swayidle {inherit pkgs;};
}
