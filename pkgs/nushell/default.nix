{
  pkgs,
  inputs,
  ...
}: let
  toml = pkgs.formats.toml {};

  starship-settings = import ./starship.nix;

  config = import ./config.nix {inherit pkgs;};
  aliases = import ./aliases.nix {inherit pkgs;};

  packages = import ./packages.nix {inherit pkgs;};

  aliasesStr =
    pkgs.lib.concatStringsSep "\n"
    (pkgs.lib.mapAttrsToList (k: v: "alias ${k} = ${v}") aliases);
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers.nushell = {
          basePackage = pkgs.nushell;
          pathAdd = with inputs.self.packages.${pkgs.system}; [ helix bottom ]++ packages;
          flags = [
            "--config"
            (pkgs.writeText "config.nu" (config + aliasesStr))
          ];
          env.STARSHIP_CONFIG.value = toml.generate "starship.toml" starship-settings;
        };
      }
    ];
  }
