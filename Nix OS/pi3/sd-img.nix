{ pkgs, ... }: {
  nixpkgs.crossSystem.system = "aarch64-linux";
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest; # Raspberry pies have a hard time booting on the LTS kernel.
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  system.stateVersion = "22.05";
}
