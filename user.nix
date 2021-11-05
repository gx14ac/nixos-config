{ pkgs, ... }:

{
  users.users.snt = {
    isNormalUser = true;
    home = "/home/snt";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
}
