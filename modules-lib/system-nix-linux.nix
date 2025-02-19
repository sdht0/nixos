{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./system-nix-common.nix
    ./system-nix-command-not-found.nix
  ];

  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp/nix-daemon";

  # Purely flake-based system
  nix.channel.enable = false;

  system.switch.enable = false;
  system.switch.enableNg = true;
  system.rebuild.enableNg = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
}
