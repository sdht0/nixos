{
  lib,
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
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    settings.Resolve.FallbackDNS = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
