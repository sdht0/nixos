{
  config,
  lib,
  pkgs,
  ...
}:
{
  systemd.timers."mullvad-reset" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "30m";
      OnUnitActiveSec = "30m";
      Unit = "mullvad-reset.service";
    };
  };

  systemd.services."mullvad-reset" = {
    path = with pkgs; [
      mullvad
      systemd
      coreutils
      gnugrep
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/mullvad-reset.sh";
      User = "root";
    };
  };
}
