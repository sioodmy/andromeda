{
  inputs,
  pkgs,
  ...
}:
inputs.wrapper-manager.lib.build {
  inherit pkgs;
  modules = [
    {
      wrappers = {
        andromeda-niri = {
          basePackage = inputs.niri.packages.${pkgs.system}.niri-unstable;
          flags = ["--config" "${import ./config.nix {inherit inputs pkgs;}}"];
          pathAdd = (with inputs.self.packages.${pkgs.system}; [andromeda nucleus]) ++ (with pkgs; [pamixer brightnessctl swaybg wlsunset]);
        };
      };
    }
  ];
}
