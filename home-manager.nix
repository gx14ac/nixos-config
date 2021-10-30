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
}
