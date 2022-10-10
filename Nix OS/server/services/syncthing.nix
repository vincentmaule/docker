{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
      dataDir = "/home/shaggy";
      configDir = "/home/shaggy/.config/syncthing";
      user = "shaggy";
      group = "users";
      openDefaultPorts = true;

      overrideDevices = false;     # overrides any devices added or deleted through the WebUI
      overrideFolders = false;     # overrides any folders added or deleted through the WebUI

      guiAddress = "0.0.0.0:8384";
  };
}
