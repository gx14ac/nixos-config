{
  description = "shintard NixOS system enviroment and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish/master";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, bobthefish }: {
    nixosConfigurations = {
      vm-intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit bobthefish;
        modules = [
          ./configuration.nix
	  ./hardware-configuration.nix
	  ./user.nix
	  ./common.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.snt = import ./home-manager.nix;
          }
        ];
      };
    };
  };
}

