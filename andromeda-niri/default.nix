{
  inputs,
  pkgs,
  ...
}: let
  as-service = pkgs.writeShellScriptBin "as-service" ''
    exec ${pkgs.systemd}/bin/systemd-run \
      --slice=app-manual.slice \
      --property=ExitType=cgroup \
      --user \
      --wait \
      bash -lc "$@"
  '';
in
  inputs.wrapper-manager.lib.build {
    inherit pkgs;
    modules = [
      {
        wrappers = {
          andromeda-niri = {
            basePackage = inputs.niri.packages.${pkgs.system}.niri-unstable;
            flags = ["--config" "${import ./config.nix {inherit inputs pkgs;}}"];
            pathAdd = with pkgs; with inputs.self.packages.${system}; [andromeda nucleus as-service pamixer brightnessctl swaybg wlsunset];
          };
        };
      }
    ];
  }
