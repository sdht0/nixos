{ config, pkgs, ... }:
{
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" ];
}
