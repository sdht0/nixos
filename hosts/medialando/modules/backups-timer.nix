{
  config,
  lib,
  pkgs,
  hostData,
  ...
}:
{
  systemd.timers."backup-root" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "23:00";
      Unit = "backup-root.service";
    };
  };

  systemd.services."backup-root" = {
    path = config.environment.systemPackages;
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup-root.sh";
      User = "root";
    };
  };

  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "06:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    path = config.environment.systemPackages;
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup.sh";
      User = hostData.users.mainuser.username;
    };
  };
}
