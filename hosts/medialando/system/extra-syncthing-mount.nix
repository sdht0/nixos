{
  config,
  lib,
  pkgs,
  ...
}:
{
  systemd.services.syncthing = {
    bindsTo = [ "opt-mnt-backups.mount" ];
    after = [ "opt-mnt-backups.mount" ];
  };
  services.syncthing.guiAddress = "100.113.188.30:8384";
}
