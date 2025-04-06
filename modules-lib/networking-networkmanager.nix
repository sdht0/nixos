{
  lib,
  config,
  pkgs,
  ...
}:
{
  networking.networkmanager = {
    enable = true;
    wifi.macAddress = "stable";
    ethernet.macAddress = "stable";
    insertNameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
    plugins = lib.mkForce [ ]; # Disable default plugins
  };
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [
        ""
        "${pkgs.networkmanager}/bin/nm-online -q"
      ];
    };
  };
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    fallbackDns = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
