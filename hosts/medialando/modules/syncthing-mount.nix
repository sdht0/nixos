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
}
