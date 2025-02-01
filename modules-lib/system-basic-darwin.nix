{
  lib,
  config,
  pkgs,
  hostData,
  ...
}:
let
  hostname = hostData.hostname;
in
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;
}
