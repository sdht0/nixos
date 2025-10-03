{
  config,
  lib,
  pkgs,
  hostData,
  ...
}:
let
  mainUser = hostData.users.mainuser.username;
  home = "/home/${hostData.users.mainuser.username}";
in
{
  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "11,15,19,22:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${home}/.config/dotfiles.safe/scripts/backup.sh";
      User = mainUser;
    };
    environment = {
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
      PATH = lib.mkForce "/run/current-system/sw/bin";
    };
  };

  systemd.services."selfwatcher" = {
    after = [ "display-manager.service" ];
    wantedBy = [ "display-manager.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${config.myPythonSet}/bin/python ${home}/.config/dotfiles.safe/scripts/selfwatcher.py";
      User = mainUser;
      Restart = "always";
      RestartSec = 10;
    };
    environment = {
      PATH = lib.mkForce "/run/current-system/sw/bin";
    };
  };
}
