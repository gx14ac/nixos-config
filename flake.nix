{
  description = "shintard NixOS system enviroment and tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

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

    vim-dracula = {
      url = "github:dracula/vim";
      flake = false;
    };

    nord-vim = {
      url = "github:arcticicestudio/nord-vim";
      flake = false;
    };

    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };

    nvim-treesitter-playground = {
      url = "github:nvim-treesitter/playground";
      flake = false;
    };

    nvim-treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects";
      flake = false;
    };

    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    nvim-lspinstall = {
      url = "github:williamboman/nvim-lsp-installer";
      flake = false;
    };

    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };

    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };

    cmp-vsnip = {
      url = "github:hrsh7th/cmp-vsnip";
      flake = false;
    };

    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };

    vim-vsnip = {
      url = "github:hrsh7th/vim-vsnip";
      flake = false;
    };

    nvim-tree = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, 
  	home-manager, theme-bobthefish, fish-fzf, fish-ghq, tmux-pain-control,
	tmux-dracula, vim-fish, vim-fugitive, vim-dracula, nord-vim, nvim-treesitter, 
	nvim-treesitter-playground, nvim-treesitter-textobjects, nvim-lspconfig,
	nvim-lspinstall, nvim-cmp, cmp-nvim-lsp, cmp-vsnip, cmp-buffer, vim-vsnip, nvim-tree, }:
  let
    mkHome = import ./home-manager.nix;
    overlays = import ./overlays.nix {
    	inherit vim-fish vim-fugitive
	vim-dracula nord-vim nvim-treesitter
	nvim-treesitter-playground nvim-treesitter-textobjects
	nvim-lspconfig nvim-lspinstall nvim-cmp
	cmp-nvim-lsp cmp-vsnip cmp-buffer vim-vsnip nvim-tree; };
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

