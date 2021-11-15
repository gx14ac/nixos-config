{ vim-fish, vim-fugitive }:

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
  };
}
