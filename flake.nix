{
  description = "NixOS PC — modular flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      myOverlays = import ./overlays { inherit inputs; };
    in {
      nixosConfigurations.NixOS-PC = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nix.settings = {
              experimental-features = [ "nix-command" "flakes" ];
              auto-optimise-store = true;
              trusted-users = [ "root" "boguskladik" ];
              substituters = [ "https://cache.nixos.org" ];
            };

            nixpkgs = {
              overlays = with myOverlays; [ unstable-packages ];
              config.allowUnfree = true;
            };

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.boguskladik = import ./home-manager/home.nix;

            # home-manager.extraSpecialArgs = { };
          }
        ];
      };
    };
}
