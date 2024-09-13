{ lib, config, pkgs, hostData, ... }:
{
  nix.useDaemon = true;

  nix.gc.automatic = false;
  nix.gc.interval = [
    {
      Hour = 3;
      Minute = 15;
    }
  ];
}
