{ pkgs, ... }: {
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
  ];

  users.users = {
    shaggy = {
      password = "test";
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
      ];
    };
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };
  
  system.stateVersion = "22.05";
}