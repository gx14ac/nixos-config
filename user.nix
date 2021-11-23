{ pkgs, ... }:

{
  users.users.shinta = {
    isNormalUser = true;
    home = "/home/shinta";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };
}
