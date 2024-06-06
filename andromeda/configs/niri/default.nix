{
  inputs,
  pkgs,
  ...
}: {
  basePackage = inputs.niri.packages.${pkgs.system}.niri-unstable;
  flags = ["--config" "${import ./config.nix {inherit inputs pkgs;}}"];
}
