{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.andromeda;
  inherit (lib) mkIf generators;
in {
  config = mkIf cfg.enable {
    environment.etc."xdg/gtk-3.0/settings.ini".text = generators.toINI {} {
      Settings = {
        gtk-application-prefer-dark-theme = 1;
        gtk-cursor-theme-name = "Bibata-Modern-Classic";
        gtk-cursor-theme-size = 16;
        gtk-font-name = "Lexend";
        gtk-icon-theme-name = "Papirus";
        gtk-theme-name = "Catppuccin-Frappe-Compact-Pink-Dark";
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
      };
    };
    environment.systemPackages = with pkgs; [
      lexend
      bibata-cursors
      (catppuccin-gtk.override {
        accents = ["pink"];
        tweaks = ["rimless"];
        size = "compact";
        variant = "frappe";
      })
    ];
  };
}
