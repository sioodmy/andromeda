{
  pkgs,
  inputs,
  ...
}: let
  configs = import ./configs {inherit inputs pkgs;};
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = configs;
      }
    ];
  }
