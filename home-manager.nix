name: { bobthefish }:

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

    pkgs.tlaplusToolbox
    pkgs.tetex
  ];

  programs.home-manager = {
    enable = true;
    path = "…";
  };

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
  };
  
  programs.fish = {
    enable = true;

    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      (builtins.readFile ./config.fish)

      "source ${bobthefish}/functions/fish_prompt.fish"
      #"source ${inputs.theme-bobthefish}/fish_right_prompt.fish"
      #"source ${inputs.theme-bobthefish}/fish_title.fish"

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
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";

    # avoid entering a password Save the key permanently
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };
}
