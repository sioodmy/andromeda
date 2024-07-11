{
  description = "My attempt to declutter my dotfiles";

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {pkgs, ...}: {
        packages = rec {
          nucleus = import ./nucleus/pkg.nix {inherit pkgs inputs;};
          default = nucleus;
        };
        devShells.default = pkgs.mkShell {
          buildInputs = [inputs.self.packages.${pkgs.system}.nucleus];
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
      flake = {
        nixosModules = rec {
          andromeda = import ./module.nix inputs;
          default = andromeda;
        };
      };
      imports = [
        inputs.treefmt-nix.flakeModule
      ];
    };

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
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    zsh-auto-notify = {
      url = "github:MichaelAquilina/zsh-auto-notify";
      flake = false;
    };
  };
}
