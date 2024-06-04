{
  description = "My attempt to declutter my dotfiles";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {pkgs, ...}: {
        packages = rec {
          seashell = pkgs.callPackage ./seashell {inherit pkgs inputs;};
          default = seashell;
        };
        devShells.default = pkgs.mkShell {
          packages = [
            inputs.self.packages.${pkgs.system}.default
          ];
          name = "seashell";
          shellHook = ''
            seashell
          '';
        };
        formatter = pkgs.alejandra;
      };
    };
}
