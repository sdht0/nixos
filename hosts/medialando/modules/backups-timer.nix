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
    path = with pkgs; [
      bash
      coreutils
      gnutar
      gnupg
      zstd
      gitFull
      rclone
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup-forejo.sh";
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
    path = with pkgs; [
      coreutils
      gawk
      gitFull
      rclone
      isync
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup.sh";
      User = hostData.users.mainuser.username;
    };
  };
}
