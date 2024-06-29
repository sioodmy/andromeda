{
  pkgs,
  inputs,
}: let
  # hardcore base16 color values for use without nixos module
  # by default we use catppuccin frappe
  cfg.theme.colors = {
    accent = "f4b8e4";
    base00 = "303446";
    base01 = "292c3c";
    base02 = "414559";
    base03 = "51576d";
    base04 = "626880";
    base05 = "c6d0f5";
    base06 = "f2d5cf";
    base07 = "babbf1";
    base08 = "e78284";
    base09 = "ef9f76";
    base0A = "e5c890";
    base0B = "a6d189";
    base0C = "81c8be";
    base0D = "8caaee";
    base0E = "ca9ee6";
    base0F = "eebebe";
  };
in
  pkgs.callPackage ./default.nix {inherit pkgs inputs cfg;}
