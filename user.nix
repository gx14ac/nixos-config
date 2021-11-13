{ pkgs, ... }:

{
  users.users.shinta = {
    isNormalUser = true;
    home = "/home/shinta";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
}
