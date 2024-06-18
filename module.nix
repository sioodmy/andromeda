inputs: {
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  cfg = config.programs.andromeda;

  package = inputs.self.packages.${system}.default;
  inherit (lib) mkOption mkEnableOption types mkIf;
in {
  imports = [./gtk];
  options.programs.andromeda = {
    enable = mkEnableOption "rice :3";
    theme = {
      colors = {
        # by default we use catppuccin frappe base16
        base00 = mkOption {
          type = types.str;
          default = "303446";
        };
        base01 = mkOption {
          type = types.str;
          default = "292c3c";
        };
        base02 = mkOption {
          type = types.str;
          default = "414559";
        };
        base03 = mkOption {
          type = types.str;
          default = "51576d";
        };
        base04 = mkOption {
          type = types.str;
          default = "626880";
        };
        base05 = mkOption {
          type = types.str;
          default = "c6d0f5";
        };
        base06 = mkOption {
          type = types.str;
          default = "f2d5cf";
        };
        base07 = mkOption {
          type = types.str;
          default = "babbf1";
        };
        base08 = mkOption {
          type = types.str;
          default = "e78284";
        };
        base09 = mkOption {
          type = types.str;
          default = "ef9f76";
        };
        base0A = mkOption {
          type = types.str;
          default = "e5c890";
        };
        base0B = mkOption {
          type = types.str;
          default = "a6d189";
        };
        base0C = mkOption {
          type = types.str;
          default = "81c8be";
        };
        base0D = mkOption {
          type = types.str;
          default = "8caaee";
        };
        base0E = mkOption {
          type = types.str;
          default = "ca9ee6";
        };
        base0F = mkOption {
          type = types.str;
          default = "eebebe";
        };
      };
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with inputs.self.packages.${pkgs.system}; [andromeda andromeda-niri nucleus];
  };
}
