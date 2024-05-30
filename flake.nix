{
  description = "My attempt to declutter my dotfiles";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        packages = import ./pkgs {inherit pkgs inputs;};
        devShells.default = let
          shell = inputs.self.packages.${pkgs.system}.default;
        in
          pkgs.mkShell {
            packages = [
              shell
            ];
            name = "seashell";
            shellHook = ''
              ${shell}/bin/nu
            '';
          };
        formatter = pkgs.alejandra;
      };
    };
}
