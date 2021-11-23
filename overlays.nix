{ vim-fish, vim-fugitive, vim-dracula, nord-vim,
  nvim-treesitter, nvim-treesitter-playground,
  nvim-treesitter-textobjects, nvim-lspconfig,
  nvim-lspinstall, nvim-cmp, cmp-nvim-lsp,
  cmp-vsnip, cmp-buffer, vim-vsnip, nvim-tree,
}:

let 
  vim= import ./vim.nix { inherit vim-fish vim-fugitive
  	vim-dracula nord-vim nvim-treesitter
 	nvim-treesitter-playground nvim-treesitter-textobjects
	nvim-lspconfig nvim-lspinstall nvim-cmp
	cmp-nvim-lsp cmp-vsnip cmp-buffer vim-vsnip nvim-tree; };
in {
  nixpkgs.overlays = [
    vim
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/1dd99a6c91b4a6909e66d0ee69b3f31995f38851.tar.gz;
      sha256 = "1z8gx1cqd18s8zgqksjbyinwgcbndg2r6wv59c4qs24rbgcsvny9";
    }))
  ];
}
