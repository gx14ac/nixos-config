name: { theme-bobthefish, fish-fzf, fish-ghq, tmux-pain-control, tmux-dracula }:

{ lib, config, pkgs, ... }:

{
  home.packages = [
    pkgs.fzf
    pkgs.git-crypt
    pkgs.htop
    pkgs.jq
    pkgs.rofi
    pkgs.go
    pkgs.gopls
    pkgs.tree
    pkgs.watch
    pkgs.zathura
    pkgs.ghq

    pkgs.tlaplusToolbox
    pkgs.tetex
  ];

  programs.direnv= {
    enable = true;
    config = {
      whitelist = {
        prefix= [
          "$HOME/source/go/src/github.com/shintard"
        ];
      };
    };
  };

  programs.go = {
    enable = true;
    goPath = "source/go";
    goPrivate = [ "github.com/shintard" ];
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "xterm-256color";
    shortcut = "x";

    extraConfig = ''
      set -ga terminal-overrides ",*256col*:Tc"

      set -g @dracula-show-battery false
      set -g @dracula-show-network false
      set -g @dracula-show-weather false
      set -g @plugin 'tmux-plugins/tmux-pain-control'

      run-shell ${tmux-pain-control}/pain_control.tmux
      run-shell ${tmux-dracula}/dracula.tmux
    '';
  };

  programs.gpg.enable = true;

  programs.git = {
    enable = true;
    userName = "Shintarou Okumura";
    userEmail = "shintarou.okumula@gmail.com";
    signing = {
      key = "C9C0D04DD5A2BA56";
      signByDefault = true;
    };
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
    };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = "";
      credential.helper = "store";
      github.user = "shinta";
      push.default = "upstream";
      init.defaultBranch = "main";
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      "source ${theme-bobthefish}/functions/fish_prompt.fish"
      "source ${theme-bobthefish}/functions/fish_right_prompt.fish"
      "source ${theme-bobthefish}/functions/fish_title.fish"
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gp = "git push";
      gpo = "git push origin";
      gs = "git status";
      gt = "git tag";
    };

    plugins = [
      {
        name = "theme-bobthefish";
        src  = theme-bobthefish;
      }
      {
        name = "fish-fzf";
        src  = fish-fzf;
      }
      {
        name = "fish-ghq";
        src  = fish-ghq;
      }
    ];
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";

    # avoid entering a password Save the key permanently
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    plugins = with pkgs; [
      customVim.vim-fish
      customVim.vim-fugitive
      customVim.vim-dracula
      customVim.nvim-treesitter
      customVim.nvim-treesitter-playground
      customVim.nvim-treesitter-textobjects
      customVim.nvim-lspconfig
      customVim.nvim-lspinstall
      customVim.nvim-cmp
      customVim.cmp-nvim-lsp
      customVim.cmp-vsnip
      customVim.cmp-buffer
      customVim.vim-vsnip

      vimPlugins.ctrlp
      vimPlugins.vim-airline
      vimPlugins.vim-airline-themes
      vimPlugins.vim-eunuch
      vimPlugins.vim-gitgutter
      vimPlugins.vim-markdown
      vimPlugins.vim-nix
      vimPlugins.typescript-vim
    ];

    extraConfig = import ./vim-config.nix;
  };
}
