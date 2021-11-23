{ vim-fish, vim-fugitive, vim-dracula, nord-vim,
  nvim-treesitter, nvim-treesitter-playground,
  nvim-treesitter-textobjects, nvim-lspconfig,
  nvim-lspinstall, nvim-cmp, cmp-nvim-lsp,
  cmp-vsnip, cmp-buffer, vim-vsnip, nvim-tree,
}:

self: super:

{
  customVim = with self; {
    vim-fish = vimUtils.buildVimPlugin {
      name = "vim-fish";
      src = vim-fish;
    };

    vim-fugitive = vimUtils.buildVimPlugin {
      name = "vim-fugitive";
      src = vim-fugitive;
    };

    vim-dracula = vimUtils.buildVimPlugin {
      name = "vim-dracula";
      src = vim-dracula;
    };

    nord-vim = vimUtils.buildVimPlugin {
      name = "nord-vim";
      src = nord-vim;
    };

    nvim-treesitter = vimUtils.buildVimPlugin {
      name = "nvim-treesitter";
      src = nvim-treesitter;
    };

    nvim-treesitter-playground = vimUtils.buildVimPlugin {
      name = "nvim-treesitter-playground";
      src = nvim-treesitter-playground;
    };

    nvim-treesitter-textobjects = vimUtils.buildVimPlugin {
      name = "nvim-treesitter-textobjects";
      src = nvim-treesitter-textobjects;
    };

    nvim-lspconfig = vimUtils.buildVimPlugin {
      name = "nvim-lspconfig";
      src = nvim-lspconfig;

      buildPhase = ":";
    };

    nvim-lspinstall = vimUtils.buildVimPlugin {
      name = "nvim-lspinstall";
      src = nvim-lspinstall;
    };

    nvim-cmp = vimUtils.buildVimPlugin {
      name = "nvim-cmp";
      src = nvim-cmp;

      buildPhase = ":";
    };

    cmp-nvim-lsp = vimUtils.buildVimPlugin {
      name = "cmp-nvim-lsp";
      src = cmp-nvim-lsp;
    };

    cmp-vsnip = vimUtils.buildVimPlugin {
      name = "cmp-vsnip";
      src = cmp-vsnip;
    };

    cmp-buffer = vimUtils.buildVimPlugin {
      name = "cmp-buffer";
      src = cmp-buffer;
    };

    vim-vsnip = vimUtils.buildVimPlugin {
      name = "vim-vsnip";
      src = vim-vsnip;
    };

    nvim-tree = vimUtils.buildVimPlugin {
      name = "nvim-tree";
      src = nvim-tree;
    };
  };
}
