{
  description = "shintard NixOS system enviroment and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    theme-bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fish-fzf = {
      url = "github:jethrokuan/fzf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, theme-bobthefish, fish-fzf }@inputs: let
    mkVM = import ./home-manager.nix;
  in {
    nixosConfigurations = {
      vm-intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
	  ./hardware-configuration.nix
	  ./user.nix
	  ./common.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shinta = mkVM "hoge" rec { 
              inherit theme-bobthefish fish-fzf; 
	    };
          }
        ];
      };
    };
  };
}

