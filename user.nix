{ pkgs, ... }:

{
  users.users.snt = {
    isNormalUser = true;
    home = "/home/snt";
    #extraGroups = [ "docker" "wheel" ];
    #shell = pkgs.fish;
  };
}
