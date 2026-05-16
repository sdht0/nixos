{ hostData, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = hostData.hostId;
  boot.zfs.forceImportRoot = false;
}
