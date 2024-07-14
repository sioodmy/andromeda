{
  inputs,
  pkgs,
  cfg,
  ...
}: let
  infoscript = import ./infoscript.nix pkgs;
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          andromeda-niri = {
            basePackage = inputs.niri.packages.${pkgs.system}.niri-unstable;
            flags = ["--config" "${import ./config.nix {inherit inputs pkgs cfg;}}"];
            pathAdd = [cfg.andromeda cfg.nucleus infoscript] ++ (with pkgs; [pamixer brightnessctl swaybg wlsunset]);
          };
        };
      }
    ];
  }
