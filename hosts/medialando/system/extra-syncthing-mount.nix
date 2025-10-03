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
  services.syncthing.guiAddress = "100.80.143.36:8384";
}
