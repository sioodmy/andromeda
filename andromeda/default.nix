{
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = config.programs.andromeda;
  configs = import ./configs {inherit inputs pkgs cfg;};
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = configs;
      }
    ];
  }
