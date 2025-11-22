{
  lib,
  pkgs,
  hostData,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    rclone # gdrive sync
    isync # mail sync
  ];

  systemd.timers."backup-root" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "23:00";
      Unit = "backup-root.service";
    };
  };

  systemd.services."backup-root" = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup-root.sh";
      User = "root";
    };
    environment = {
      PATH = lib.mkForce "/run/current-system/sw/bin";
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
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup.sh";
      User = hostData.users.mainuser.username;
    };
    environment = {
      PATH = lib.mkForce "/run/current-system/sw/bin";
    };
  };

  systemd.timers."zfs-status-check" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*:0/5";
      Unit = "zfs-status-check.service";
    };
  };

  systemd.services."zfs-status-check" = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/zfs-status-check.sh";
      User = hostData.users.mainuser.username;
    };
    environment = {
      PATH = lib.mkForce "/run/current-system/sw/bin";
    };
  };
}
