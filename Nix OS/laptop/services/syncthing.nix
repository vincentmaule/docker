{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
      dataDir = "/home/shaggy";
      configDir = "/home/shaggy/Documents/.config/syncthing";
      user = "shaggy";
      group = "users";
      openDefaultPorts = true;

      overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      overrideFolders = true;     # overrides any folders added or deleted through the WebUI

      guiAddress = "0.0.0.0:8384";

      devices = {
        "v-phone" = { id = "SLG3NHW-EUBMVHO-WOAJBD3-UEX3VAY-OBT5DUH-RX4K6LK-M5W4523-VCAAOQE"; };
        #"device2" = { id = "DEVICE-ID-GOES-HERE"; };
      };

      folders = {
        "ltp" = {        # Name of folder in Syncthing, also the folder ID
          path = "/home/shaggy";    # Which folder to add to Syncthing
          devices = [ "v-phone" ];      # Which devices to share the folder with
          type = "sendonly";
          versioning = {
            type = "simple";
            params = {
              keep = "3";
            };
          };
        };
      };
  };
}
