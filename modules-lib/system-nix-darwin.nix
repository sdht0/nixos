{
  lib,
  config,
  pkgs,
  hostData,
  ...
}:
{
  imports = [ ./system-nix-common.nix ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.gc.automatic = false;
  nix.gc.interval = [
    {
      Hour = 3;
      Minute = 15;
    }
  ];
}
