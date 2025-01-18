{
  lib,
  config,
  pkgs,
  hostData,
  ...
}:
{
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp/nix-daemon";

  system.switch.enable = false;
  system.switch.enableNg = true;
  system.rebuild.enableNg = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
}
