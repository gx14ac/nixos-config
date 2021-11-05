{ config, pkgs, currentSystem, ... }:
{
  # nix flakes install
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel Version
  boot.kernelPackages = pkgs.linuxPackages_5_14;

  # For hidpi machines
  hardware.video.hidpi.enable = true;
  
  # Networking 
  networking.hostName = "dev";
  
  networking.useDHCP = false;

  networking.interfaces.ens33.useDHCP = true;

  # Security
  security.sudo.wheelNeedsPassword = false;
  
  # System
  system.stateVersion = "21.05";

  # Timezone
  time.timeZone = "Asia/Tokyo";

  # Virtualisation
  virtualisation.docker.enable = true;
  virtualisation.vmware.guest.enable = true;
  
  # defaultLocale
  i18n.defaultLocale = "en_US.UTF-8";

  # firewall
  networking.firewall.enable = false;

  # ssh
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = true;
  services.openssh.permitRootLogin = "yes";
}
