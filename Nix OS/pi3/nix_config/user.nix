{ config, pkgs, ... }:

{

  imports =
    [ # Include the results of the hardware scan.
      # services/syncthing.nix
      services/tailscale.nix
    ];

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.
  shaggy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      thunderbird
      virt-manager
    ];
  };
}