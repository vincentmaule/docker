{ pkgs, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
  ];

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  
  system.stateVersion = "22.05";
}