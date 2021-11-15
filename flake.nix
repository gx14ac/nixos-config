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
      flake = false;
    };

    fish-fzf = {
      url = "github:jethrokuan/fzf";
      flake = false;
    };

    fish-ghq = {
      url = "github:decors/fish-ghq";
      flake = false;
    };

    tmux-pain-control = {
      url = "github:tmux-plugins/tmux-pain-control";
      flake = false;
    };

    tmux-dracula = {
      url = "github:dracula/tmux";
      flake = false;
    };

    vim-fish = {
      url = "github:dag/vim-fish";
      flake = false;
    };

    vim-fugitive = {
      url = "github:tpope/vim-fugitive";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, theme-bobthefish, fish-fzf, fish-ghq, tmux-pain-control,
    tmux-dracula, vim-fish, vim-fugitive }:
  let
    #system = "x86_64-linux";
    #pkgs = import nixpkgs {
    #  inherit system;
    #};

    mkHome = import ./home-manager.nix;
    overlays = import ./overlays.nix { inherit vim-fish vim-fugitive; };
  in {
    nixosConfigurations = {
      vm-intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
	  ./hardware-configuration.nix
	  ./user.nix
	  ./common.nix
	  overlays
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shinta = mkHome "shinta" rec { 
              inherit theme-bobthefish fish-fzf fish-ghq tmux-pain-control tmux-dracula;
	    };
          }
        ];
      };
    };
  };
}

