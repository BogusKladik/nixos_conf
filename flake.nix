{
  description = "A simple NixOS flake";

  nixConfig = { };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
    in {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations.NixOS-PC = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            _module.args = { inherit inputs outputs; };

            nix.settings.trusted-users = [ "root" "boguskladik" ];

            nix.settings = {
              substituters = [ "https://cache.nixos.org" ];

              trusted-public-keys = [ ];
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.boguskladik = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs outputs; };
          }
        ];
      };
    };
}
