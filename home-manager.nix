name: { theme-bobthefish, fish-fzf, fish-ghq }:

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

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "xterm-256color";
    shortcut = "l";
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

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";

    # avoid entering a password Save the key permanently
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };
}
