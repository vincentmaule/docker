# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      /home/shaggy/user.nix
    ];

  networking.hostName = "v-home-server"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Detroit";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Emulation of x64
    binfmt.emulatedSystems = ["aarch64-linux"];
  };
  
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      };
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  programs.dconf.enable = true;


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    cloudflared = {
      isSystemUser = true;
      group = "cloudflared";
      packages = with pkgs; [ 
        cloudflared
      ];
    };
  };

  users.groups.cloudflared = {};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    virt-manager
    tailscale
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # }; 

  networking = {
    firewall = {
      enable = true;
      #trustedInterfaces = [ "tailscale0" ];
      checkReversePath = "loose";
      # allowedTCPPorts = [17932 22];
      # allowedUDPPorts = [config.services.tailscale.port];
    };
    interfaces.enp3s0.ipv4.addresses = [ {
      address = "10.0.0.150";
      prefixLength = 24;
    } ];

    defaultGateway = "10.0.0.1";
    nameservers = [ "8.8.8.8" ];
  };
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  nixpkgs.config.allowUnfree = true;
}