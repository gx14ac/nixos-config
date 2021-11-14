{ vim-fish }:

self: super:

{
  customVim = with self; {
    vim-fish = vimUtils.buildVimPlugin {
      name = "vim-fish";
      src = vim-fish;
    };
  };
}
