{
  inputs,
  pkgs,
  ...
}: {
  foot = import ./foot {inherit inputs pkgs;};
  ags = import ./ags {inherit inputs pkgs;};

  gtklock = import ./gtklock {inherit pkgs;};
  rofi = import ./rofi {inherit pkgs;};
  swayidle = import ./swayidle {inherit pkgs;};
}
