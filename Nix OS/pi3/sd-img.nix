{ pkgs, ... }: {
  nixpkgs.crossSystem.system = "aarch64-linux";
  
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-raspberrypi-installer.nix>
  ];

  boot.kernelPackages = pkgs.linuxPackages_rpi3;
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  system.stateVersion = "22.05";
}
