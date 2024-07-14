{
  inputs,
  pkgs,
  cfg,
  ...
}: {
  foot = import ./foot {inherit inputs pkgs cfg;};

  gtklock = import ./gtklock {inherit pkgs;};
  mako = import ./mako {inherit pkgs cfg;};
  rofi = import ./rofi {inherit pkgs cfg;};
  swayidle = import ./swayidle {inherit pkgs;};
}
