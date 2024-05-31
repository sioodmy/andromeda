{
  pkgs,
  inputs,
  ...
}: let
  toml = pkgs.formats.toml {};

  starship-settings = import ./starship.nix;

  nuconfig = import ./config.nix {inherit pkgs;};
  aliases = import ./aliases.nix {inherit pkgs;};
  configs = import ./configs {inherit inputs pkgs;};

  packages = import ./packages.nix {inherit pkgs;};

  aliasesStr =
    pkgs.lib.concatStringsSep "\n"
    (pkgs.lib.mapAttrsToList (k: v: "alias ${k} = ${v}") aliases);
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers =
          {
            seashell = {
              basePackage = pkgs.nushellFull;
              pathAdd = packages;
              flags = [
                "--config"
                (pkgs.writeText "config.nu" (nuconfig + aliasesStr))
                # we don't really need it
                "--env-config"
                "/dev/null"
              ];
              env.STARSHIP_CONFIG.value = toml.generate "starship.toml" starship-settings;
              renames = {
                "nu" = "seashell";
              };
            };
          }
          // configs;
      }
    ];
  }
