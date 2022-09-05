{ config, pkgs, lib, ... }:
{

  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];
  
  boot = {
    kernelParams = ["cma=32M"];
    
    # !!! Otherwise (even if you have a Raspberry Pi 2 or 3), pick this:
    kernelPackages = pkgs.linuxPackages_rpi3;

    # Cleanup tmp on startup
    cleanTmpDir = true;
    
    loader = {
      raspberryPi.version = 3;
      raspberryPi.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  # !!! Adding a swap file is optional, but strongly recommended!
  swapDevices = [ { device = "/swapfile"; size = 1024; } ];

  # Set hostname
  networking.hostName = "pi";
}