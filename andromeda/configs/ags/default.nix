{
  inputs,
  pkgs,
  ...
}: let
  config = pkgs.stdenv.mkDerivation {
    pname = "ags-config";
    version = "0.0.1";
    buildInputs = [pkgs.dart-sass];
    src = ./.;
    buildPhase = ''
      mkdir -p $out/
      sass style.scss:style.css
    '';
    installPhase = ''
      cp -r style.css *.js services style utils windows -t $out/
    '';
  };
in {
  basePackage = inputs.ags.packages.${pkgs.system}.ags;
  flags = ["--config" "${config}/config.js"];
}
