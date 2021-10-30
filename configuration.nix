# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  time.timeZone = "Japan/Tokyo";

  networking.useDHCP = false;
  networking.interfaces.ens33.useDHCP = true;
  networking.hostName = "vm-intel";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    gcc
    bash
    sysstat
  ];

  system.stateVersion = "21.05"; # Did you read the comment?
  virtualisation.vmware.guest.enable = true;
  services.sshd.enable = true;

  # nix flakes install
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}

