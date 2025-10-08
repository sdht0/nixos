{
  config,
  lib,
  pkgs,
  ...
}:
{
  systemd.services.syncthing = {
    bindsTo = [ "opt-mnt-syncs.mount" ];
    after = [ "opt-mnt-syncs.mount" ];
  };
  services.syncthing.guiAddress = "100.113.188.30:8384";
}
