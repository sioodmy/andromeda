{
  pkgs,
  inputs,
  cfg,
  ...
}: let
  toml = pkgs.formats.toml {};

  starship-settings = import ./starship.nix;

  colors = import ./nushell/colors.nix {inherit cfg;};
  aliases = import ./aliases.nix {inherit pkgs;};
  nuconfig = builtins.readFile ./nushell/config.nu;
  configs = import ./configs {inherit inputs pkgs cfg;};

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
            nucleus = {
              basePackage = pkgs.nushell;
              pathAdd = packages;
              flags = [
                "--config"
                (pkgs.writeText "config.nu" (colors + aliasesStr + nuconfig))
                # we don't really need it
                "--env-config"
                "/dev/null"
              ];
              env.STARSHIP_CONFIG.value = toml.generate "starship.toml" starship-settings;
              renames = {
                "nu" = "nucleus";
              };
            };
          }
          // configs;
      }
    ];
  }
