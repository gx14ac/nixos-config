{ pkgs, ... }:

{
  nixpkgs.overlays = [
    # vim.nix overlay, how did i pass the flake package

    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/1dd99a6c91b4a6909e66d0ee69b3f31995f38851.tar.gz;
      sha256 = "1z8gx1cqd18s8zgqksjbyinwgcbndg2r6wv59c4qs24rbgcsvny9";
    }))
  ];
}
