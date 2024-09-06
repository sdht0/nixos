{ lib, config, pkgs, hostData, ... }:
{
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp/nix-daemon";

  system.switch = {
    enable = false;
    enableNg = true;
  };

  nix.gc.dates = "daily";
}
