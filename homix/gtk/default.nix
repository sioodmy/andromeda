{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.andromeda;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    homix = let
      css = import ./colors.nix {inherit cfg;};
      gtkINI = {
        gtk-application-prefer-dark-theme = 1;
        gtk-font-name = "Lexend 11";
        gtk-icon-theme-name = "Papirus";
        gtk-theme-name = "adw-gtk3";
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
      };
    in {
      ".config/gtk-3.0/gtk.css".text = css;
      ".config/gtk.css".text = css;
      ".config/gtk-3.0/settings.ini".text = lib.generators.toINI {} {
        Settings = gtkINI;
      };
      ".config/gtk-4.0/settings.ini".text = lib.generators.toINI {} {
        Settings =
          gtkINI
          // {
            gtk-application-prefer-dark-theme = 1;
          };
      };
    };

    environment.systemPackages = with pkgs; [
      catppuccin-papirus-folders
      adw-gtk3
      lexend
    ];
  };
}
