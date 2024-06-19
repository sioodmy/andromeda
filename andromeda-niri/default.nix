{
  inputs,
  pkgs,
  config,
  ...
}: let
  cfg = config.programs.andromeda;
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          andromeda-niri = {
            basePackage = inputs.niri.packages.${pkgs.system}.niri-unstable;
            flags = ["--config" "${import ./config.nix {inherit inputs pkgs;}}"];
            pathAdd = [cfg.andromeda cfg.nucleus] ++ (with pkgs; [pamixer brightnessctl swaybg wlsunset]);
          };
        };
      }
    ];
  }
