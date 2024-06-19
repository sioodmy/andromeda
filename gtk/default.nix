{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.programs.andromeda;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    xdg.configFile = let
      css = import ./colors.nix {inherit cfg;};
    in {
      "gtk-3.0/gtk.css".text = css;
      "gtk-4.0/gtk.css".text = css;
    };

    gtk = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };
      font = {
        name = "Lexend";
        size = 11;
      };
      iconTheme = {
        package = pkgs.catppuccin-papirus-folders;
        name = "Papirus";
      };
      gtk3.extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk2.extraConfig = ''
        gtk-xft-antialias=1
        gtk-xft-hinting=1
        gtk-xft-hintstyle="hintslight"
        gtk-xft-rgba="rgb"
      '';
    };
  };
}
