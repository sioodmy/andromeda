{
  inputs,
  pkgs,
  ...
}: {
  foot = import ./foot {inherit inputs pkgs;};
  ags = import ./ags {inherit inputs pkgs;};

  gtklock = import ./gtklock {inherit pkgs;};
}
