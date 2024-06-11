{
  description = "My attempt to declutter my dotfiles";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {pkgs, ...}: {
        packages = rec {
          # cli
          nucleus = pkgs.callPackage ./nucleus {inherit pkgs inputs;};

          # my desktop
          andromeda = pkgs.callPackage ./andromeda {inherit pkgs inputs;};
          andromeda-niri = pkgs.callPackage ./andromeda-niri {inherit pkgs inputs;};
          default = nucleus;
        };
        devShells.default = pkgs.mkShell {
          packages = [
            inputs.self.packages.${pkgs.system}.default
          ];
          name = "nucleus";
          shellHook = ''
            nucleus
          '';
        };
        treefmt = {
          projectRootFile = "flake.nix";

          programs = {
            alejandra.enable = true;
            prettier.enable = true;
            stylua.enable = true;
            deadnix.enable = false;
            shellcheck.enable = true;
            shfmt = {
              enable = true;
              indent_size = 4;
            };
          };
        };
      };
      imports = [
        inputs.treefmt-nix.flakeModule
      ];
    };
}
