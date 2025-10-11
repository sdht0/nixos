{
  lib,
  pkgs,
  hostData,
  ...
}:
let
  mainUser = hostData.users.mainuser.username;
  home = "/home/${mainUser}";
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
}
