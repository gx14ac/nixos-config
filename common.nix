{ config, pkgs, currentSystem, ... }:

{

  services.xserver = {
    enable = true;
    layout = "us";
    dpi = 220;

    desktopManager = {
      xterm.enable = false;
      wallpaper.mode = "scale";
    };

    displayManager = {
      defaultSession = "none+i3";
      lightdm.enable = true;

      sessionCommands = ''
        ${pkgs.xlibs.xset}/bin/xset r rate 200 40
      '';
    };

    windowManager = {
      i3.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    firefox
    gcc
    bash
    sysstat
    gnumake
    killall
    niv
    rustup
    libclang
    sqlite
    ipfs
    xclip
  ];

  environment.enableDebugInfo = true;

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

  # fonts
  fonts = {
    fontDir.enable = true;

    fonts = [
      (builtins.path {
        name = "custom-fonts";
        path = ./fonts;
        recursive = true;
      })
    ];
  };
}
