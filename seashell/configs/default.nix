{
  inputs,
  pkgs,
  ...
}: {
  helix = import ./helix.nix {inherit inputs pkgs;};
  bottom = import ./bottom.nix {inherit inputs pkgs;};
}
