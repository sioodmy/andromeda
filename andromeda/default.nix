{
  pkgs,
  inputs,
  cfg,
  ...
}: let
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
