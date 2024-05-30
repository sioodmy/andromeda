{
  pkgs,
  inputs,
  ...
}: rec {
  nushell = pkgs.callPackage ./nushell {inherit pkgs inputs;};
  helix = pkgs.callPackage ./helix.nix {inherit pkgs inputs;};
  starship = pkgs.callPackage ./starship.nix {inherit pkgs inputs;};

  bottom = pkgs.callPackage ./bottom.nix {inherit pkgs inputs;};

  default = nushell;
}
