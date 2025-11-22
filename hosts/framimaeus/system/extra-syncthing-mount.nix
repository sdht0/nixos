{
  hostData,
  ...
}:
{
  systemd.services.syncthing = {
    bindsTo = [ "opt-mnt-backups.mount" ];
    after = [ "opt-mnt-backups.mount" ];
  };
  services.syncthing.guiAddress = "${hostData.tailscaleIp}:8384";
}
