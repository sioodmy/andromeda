{
  inputs,
  pkgs,
  cfg,
  ...
}: {
  bottom = import ./bottom.nix {inherit inputs pkgs;};
  nvim = import ./nvim {inherit inputs pkgs cfg;};
}
