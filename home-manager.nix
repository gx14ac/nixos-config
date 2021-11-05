{ pkgs, ... }:

{
  home.packages = [
    pkgs.git
    pkgs.htop
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
      key = "F29CEA2CF04FB748";
      signByDefault = true;
    };
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      root = "rev-parse --show-toplevel";
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
