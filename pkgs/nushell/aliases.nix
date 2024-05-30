{pkgs, ...}: let
  getExe = pkgs.lib.getExe;
in
  with pkgs; {
    cd = "z";
    m = "mkdir";

    g = "git";
    n = "nix";

    cat = "${getExe bat}";
    fzf = "${getExe skim}";

    kys = "shutdown now";

    gpl = "curl https://www.gnu.org/licenses/gpl-3.0.txt -o LICENSE";

    gcb = "git checkout";
    gd = "git pull";
    gu = "git push";
    gc = "git commit";
    ga = "git add";
  }
