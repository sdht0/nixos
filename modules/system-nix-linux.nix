{ lib, config, pkgs, hostData, ... }:
{
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp/nix-daemon";
}
