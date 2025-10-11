{ hostData, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = hostData.hostId;
}
